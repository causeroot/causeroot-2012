class GameResultsController < ApplicationController
  # GET /game_results
  # GET /game_results.json
  def index
    @game_results = GameResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_results }
    end
  end

  # GET /game_results/1
  # GET /game_results/1.json
  def show
    @game_result = GameResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_result }
    end
  end

  # This assigns two random but unique  
  # GET /game_results/new
  # GET /game_results/new.json
  def new
    @gdata_all = GameResult.all
    @gdata_user = GameResult.where({:user_id => @current_user}) 
    #TODO: The inputs for the question and issues should be Hash referenced, and not an Arrays
        
    @game_result = GameResult.new

    ####### IDENTIFY THE BOUNDS OF THE DATASET ########    
    idata = {}
    questions_by_all = []
    questions_by_user = []
    problems_by_all = []
    problems_by_user = []
    pq_by_all_set = {}
    pq_by_user_set = {}
    
    @gdata_all.each do |value|
        if value.skip == false && value.same == false
            questions_by_all << value.question_id
            problems_by_all << value.issue_ids[0]
            problems_by_all << value.issue_ids[1]
            if !pq_by_all_set.has_key?(value.question_id)
                pq_by_all_set.merge!(value.question_id=>[])
            end
            pq_by_all_set[value.question_id]<<value.issue_ids.sort
        end;
    end;
    
    @gdata_user.each do |value|
        if value.skip == false && value.same == false
            questions_by_user << value.question_id
            problems_by_user << value.issue_ids[0]
            problems_by_user << value.issue_ids[1]
            if !pq_by_user_set.has_key?(value.question_id)
                pq_by_user_set.merge!(value.question_id=>[])
            end
            pq_by_user_set[value.question_id]<<value.issue_ids.sort
        end;
    end;
    
    pq_by_all_set=Hash[pq_by_all_set.sort_by{|problem, freq| freq.length}]
    pq_by_user_set=Hash[pq_by_user_set.sort_by{|problem, freq| freq.length}]
    
    problems_by_all_freq_sort = Hash[problems_by_all.counts.sort_by{|problem, freq| freq}]
    questions_by_all_freq_sort = Hash[questions_by_all.counts.sort_by{|problem, freq| freq}]
    
    problems_by_user_freq_sort_rev = Hash[problems_by_user.counts.sort_by{|problem, freq| -freq}]
    questions_by_user_freq_sort = Hash[questions_by_user.counts.sort_by{|problem, freq| freq}]
    
    p_all_max = problems_by_all.max+1
    q_all_max = questions_by_all.max
    p_user_num = problems_by_user.length/2
    
    pq_by_user_set.each do |key,value|
        value.uniq!
        value.sort_by!{|a,b| a*p_all_max+b}
    end
    pq_by_all_set.each do |key,value|
        #value.uniq!
        value.sort_by!{|a,b| a*p_all_max+b}
    end 
    
    pq_by_all_set
    pq_by_user_set
    problems_by_all_freq_sort
    questions_by_all_freq_sort
    problems_by_user_freq_sort_rev
    questions_by_user_freq_sort
    
    # TODO: Address skip/flag?
    
    ques_order = questions_by_all_freq_sort.map{|k,v| k}
    prob_order = problems_by_user_freq_sort_rev.map{|k,v| k}
    temp = problems_by_all_freq_sort.map{|k,v| k}
    #TODO: Add Code here that throws out FLAGGED (SAME & SKIP?) type dudes
    temp.each do |p|
        if !prob_order.include?(p)
            prob_order<<p
        end
    end
    
    #################################################################################
    # This code limits the number of questions that are asked to a particular user
    # based upon the number of questions that the user has answered up until this point
    
    # Define Constants
    def_priority_num_of_questions = 15
    percent_weight_focus_on_completion = 0.8
    epsilon = 0.00000001
    
    
    # THIS CODE CHOOSE THE APPROPRIATE QUESTION TO ASK (with a randomizer function as well)
    q_order = questions_by_all_freq_sort.map{|k,v| Hash[k=>questions_by_user.counts[k] ]}
    # If needed, we can use: q_order = Hash[Hash[q_order.map!{|k| k.flatten}].sort_by{|k,v| v}]
    if (rand()+epsilon) < percent_weight_focus_on_completion
        next_question = Hash[q_order.map!{|k| k.flatten}].min_by{|k,v| v}[0]
    else
        next_question = rand(q_all_max)
    end
    @game_result.question = Question.offset(next_question-1).first
    
    # TODO: Reorder some of this to only group stuff based on the "choice" variable to reduce required computation
    
    
    # THIS CODE CHOOSE THE APPROPRIATE PROBLEMS TO POSE (with a randomizer function as well)
    if !pq_by_user_set[next_question] == nil
        problems_left_focus = prob_order[0..def_priority_num_of_questions].combination(@game_result.question.problem_count).to_a-pq_by_user_set[next_question]
        problems_left_rest_remaining = (prob_order.combination(@game_result.question.problem_count).to_a-pq_by_user_set[next_question])-problems_left_focus
    else
        problems_left_focus = prob_order[0..def_priority_num_of_questions].combination(@game_result.question.problem_count).to_a
        problems_left_rest_remaining = prob_order.combination(@game_result.question.problem_count).to_a-problems_left_focus
    end
    
    choice = rand()+epsilon
    
    if choice < percent_weight_focus_on_completion && problems_left_focus.length > 0
        next_question = problems_left_focus[(choice*(1.0/percent_weight_focus_on_completion))*problems_left_focus.length-1]
    elsif !problems_left_rest_remaining.length == 0
        next_question = problems_left_rest_remaining[(rand()+epsilon)*problems_left_rest_remaining.length-1 ]
    else
        next_question = prob_order.combination(@game_result.question.problem_count).to_a[(rand()+epsilon)]
    end
    
    # THIS CODE WRITES THE CHOSEN ISSUES TO THE GAME RESULT TO ASK THE USER
    a = next_question[0]-1
    b = next_question[1]-1
    if rand(2).to_i == 1
        @game_result.issues << Issue.offset(a).first
        @game_result.issues << Issue.offset(b).first
    else
        @game_result.issues << Issue.offset(b).first
        @game_result.issues << Issue.offset(a).first     
    end

    respond_to do |format|
      format.html  #new.html.erb
      format.json { render json: @game_result }
    end
  end

  # GET /game_results/1/edit
  def edit
    @game_result = GameResult.find(params[:id])
  end

  # POST /game_results
  # POST /game_results.json
  def create
    # Save user, result 
    @game_result = GameResult.new(params[:game_result])
    @game_result.user = current_user
    @game_result.save
    params[:issues].each do |issue_id|
      @game_result.issues << Issue.find(issue_id.last)
    end
    
    respond_to do |format|
      if @game_result.save
        if defined?(params[:flag])
          flagged_issue = FlaggedIssues.new do |i|
            #i.issue_id = params[:flag].first[0]
            i.game_result_id = @game_result.id
            i.save
          end
        end  

        format.html { redirect_to :action=>'new', notice: 'Game result was successfully updated.'}
        format.json { render json: @game_result, status: :created, location: @game_result }
      else
        format.html { render action: "new", notice: 'Game result was failed updated.' }
        format.json { render json: @game_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_results/1
  # PUT /game_results/1.json
  def update
    @game_result = GameResult.find(params[:id])

    respond_to do |format|
      if @game_result.update_attributes(params[:game_result])
        format.html { redirect_to @game_result, notice: 'Game result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_results/1
  # DELETE /game_results/1.json
  def destroy
    @game_result = GameResult.find(params[:id])
    @game_result.destroy

    respond_to do |format|
      format.html { redirect_to game_results_url }
      format.json { head :no_content }
    end
  end

end

class Array
    def counts
        inject( Hash.new(0) ){ |hash,element|
            hash[ element ] +=1
            hash
        }
    end
end