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
    @game_result = GameResult.new
    
    @game_result.question = Question.offset(rand(Question.count)).first

    c = Issue.count
    used = []
    for i in 1..@game_result.question.problem_count
      # prevent using the same random number twice
      iid = rand(c)
      while used.include? iid and c > 3
        iid = rand(c)
      end
      used << iid
      @game_result.issues << Issue.offset(iid).first
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
