# Game 
class GameResult < ActiveRecord::Base
  attr_accessible :question, :question_id, :user, :issues, :answer, :same, :skip
  belongs_to :user
  belongs_to :question
  has_and_belongs_to_many :issues, :join_table => "game_results_issues", :autosave => true
  after_initialize :default_values
  
  private
    def default_values
      self.skip = false if (self.has_attribute? :skip) && self.skip.nil?
      self.same = false if (self.has_attribute? :same) && self.same.nil?
    end

  def self.pick_result
    @game_result = GameResult.new

    @game_result.question = Question.offset(rand(Question.count)).first

    c = Issue.count
    used = []
    @game_result.question.problem_count.times do
      # prevent using the same random number twice
      iid = rand(c)
      while used.include? iid and c > 2
        iid = rand(c)
      end
      used << iid
      @game_result.issues << Issue.offset(iid).first
    end

    ## Define Constants
    #def_priority_num_of_questions = 15
    #percent_weight = 0.7
    #epsilon = 0.00000001
    #
    #@gdata_all = GameResult.all
    #@gdata_user = GameResult.where({:user_id => @current_user})
    ##TODO: The inputs for the question and issues should be Hash referenced, and not an Arrays
    #
    #@game_result = GameResult.new
    #
    ######## IDENTIFY THE BOUNDS OF THE DATASET ########
    #idata = {}
    #remove_problem_user = []
    #questions_by_all = []
    #questions_by_user = []
    #problems_by_all = []
    #problems_by_user = []
    #question_list = []
    #problem_list = []
    #pq_by_all_set = {}
    #pq_by_user_set = {}
    #
    ## TODO: cache results at block level - rheyns
    #
    #@gdata_all.each do |value|
    #  if value.skip == false && value.same == false
    #    questions_by_all << value.question_id
    #    problems_by_all << value.issue_ids[0]
    #    problems_by_all << value.issue_ids[1]
    #    if !pq_by_all_set.has_key?(value.question_id)
    #      pq_by_all_set.merge!(value.question_id=>[])
    #    end
    #    pq_by_all_set[value.question_id]<<value.issue_ids.sort
    #  end;
    #end;
    #
    #@gdata_user.each do |value|
    #  if value.skip == false && value.same == false
    #    questions_by_user << value.question_id
    #    problems_by_user << value.issue_ids[0]
    #    problems_by_user << value.issue_ids[1]
    #    if !pq_by_user_set.has_key?(value.question_id)
    #      pq_by_user_set.merge!(value.question_id=>[])
    #    end
    #    pq_by_user_set[value.question_id]<<value.issue_ids.sort
    #  elsif value.same
    #    remove_problem_user << value.issue_ids-[value.answer]
    #  end
    #end;
    #
    #FlaggedIssues.all.each do |f|
    #  if GameResult.find(f.game_result_id).user_id == @current_user && !f.issue_id == nil
    #    remove_problem_user << f.issue_id
    #  end
    #end
    #
    #remove_problem_user.flatten!
    #
    #Issue.all.each do |i|
    #  problem_list << i.id
    #end
    #
    #p_all_max = problem_list.max
    #
    #Question.all.each do |q|
    #  question_list << q.id
    #end
    #q_all_max = question_list.max
    #
    #pq_by_all_set=Hash[pq_by_all_set.sort_by{|problem, freq| freq.length}]
    #pq_by_user_set=Hash[pq_by_user_set.sort_by{|problem, freq| freq.length}]
    #
    #problems_by_all_freq_sort = Hash[(problems_by_all.counts.sort_by{|problem, freq| freq} + (problem_list-problems_by_all.uniq).map{|v| [v,0]}).sort_by{|problem, freq| freq}]
    #questions_by_all_freq_sort = Hash[(questions_by_all.counts.sort_by{|question, freq| freq} + (question_list-questions_by_all.uniq).map{|v| [v,0]}).sort_by{|question, freq| freq}]
    #
    ## TODO: This needs to be modified at some point to not only ask a single question excessively/heavily when a new one is added to the mix
    #
    #problems_by_user_freq_sort_rev = Hash[problems_by_user.counts.sort_by{|problem, freq| -freq}]
    ## questions_by_user_freq_sort = Hash[questions_by_user.counts.sort_by{|problem, freq| freq}]
    #
    ## p_user_num = problems_by_user.length/2
    #
    #pq_by_user_set.each do |key,value|
    #  value.uniq!
    #  value.sort_by!{|a,b| a*p_all_max+b}
    #end
    #pq_by_all_set.each do |key,value|
    #  # value.uniq!
    #  value.sort_by!{|a,b| a*p_all_max+b}
    #end
    #
    ## ques_order_partial = questions_by_all_freq_sort.map{|k,v| k}
    ## ques_order = ques_order_partial + (questions_by_all_freq_sort.map{|k,v| k}-ques_order_partial)
    #prob_order_partial = problems_by_user_freq_sort_rev.map{|k,v| k}
    #prob_order = prob_order_partial + (problems_by_all_freq_sort.map{|k,v| k}-prob_order_partial)
    #prob_order = prob_order - remove_problem_user
    #
    ##TODO: Add Code here that throws out FLAGGED (SAME & SKIP?) type dudes
    #
    ## THIS CODE CHOOSE THE APPROPRIATE QUESTION TO ASK (with a randomizer function as well)
    #q_order = questions_by_all_freq_sort.map{|k,v| Hash[k=>questions_by_user.counts[k] ]}
    ## If needed, we can use: q_order = Hash[Hash[q_order.map!{|k| k.flatten}].sort_by{|k,v| v}]
    #if (rand()+epsilon) < percent_weight
    #  next_question = Hash[q_order.map!{|k| k.flatten}].min_by{|k,v| v}[0]
    #else
    #  next_question = question_list[rand(q_all_max)]
    #end
    #@game_result.question = Question.offset(next_question-1).first
    #
    ## TODO: Reorder some of this to only group stuff based on the "choice" variable to reduce required computation
    #
    ## THIS CODE CHOOSE THE APPROPRIATE PROBLEMS TO POSE (with a randomizer function as well)
    #
    #if !pq_by_user_set[next_question] == nil
    #  problems_left_focus = prob_order[0..def_priority_num_of_questions].combination(@game_result.question.problem_count).to_a-pq_by_user_set[next_question]
    #  problems_left_rest_remaining = (prob_order.combination(@game_result.question.problem_count).to_a-pq_by_user_set[next_question])-problems_left_focus
    #else
    #  problems_left_focus = prob_order[0..def_priority_num_of_questions].combination(@game_result.question.problem_count).to_a
    #  problems_left_rest_remaining = prob_order.combination(@game_result.question.problem_count).to_a-problems_left_focus
    #end
    #
    #choice = rand()+epsilon
    #
    #if choice < percent_weight && problems_left_focus.length > 0
    #  next_question = problems_left_focus[(choice*(1.0/percent_weight))*problems_left_focus.length-1]
    #elsif problems_left_rest_remaining.length > 0
    #  next_question = problems_left_rest_remaining[(rand()+epsilon)*problems_left_rest_remaining.length-1 ]
    #else
    #  next_question = prob_order.combination(@game_result.question.problem_count).to_a[(rand()+epsilon)]
    #end
    #
    ## THIS CODE WRITES THE CHOSEN ISSUES TO THE GAME RESULT TO ASK THE USER
    #
    #a = next_question[0]-1
    #b = next_question[1]-1
    #if rand(2).to_i == 1
    #  @game_result.issues << Issue.offset(a).first
    #  @game_result.issues << Issue.offset(b).first
    #else
    #  @game_result.issues << Issue.offset(b).first
    #  @game_result.issues << Issue.offset(a).first
    #end

    return @game_result
  end
end
