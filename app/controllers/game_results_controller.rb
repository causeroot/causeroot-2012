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

  # GET /game_results/new
  # GET /game_results/new.json
  def new
    @game_result = GameResult.new

    respond_to do |format|
      format.html # new.html.erb
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
    @game_result = GameResult.new(params[:game_result])

    respond_to do |format|
      if @game_result.save
        format.html { redirect_to @game_result, notice: 'Game result was successfully created.' }
        format.json { render json: @game_result, status: :created, location: @game_result }
      else
        format.html { render action: "new" }
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
