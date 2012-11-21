class GameDataController < ApplicationController
  # GET /game_data
  # GET /game_data.json
  def index
    @game_data = GameDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_data }
    end
  end

  # GET /game_data/1
  # GET /game_data/1.json
  def show
    @game_datum = GameDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_datum }
    end
  end

  # GET /game_data/new
  # GET /game_data/new.json
  def new
    @game_datum = GameDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_datum }
    end
  end

  # GET /game_data/1/edit
  def edit
    @game_datum = GameDatum.find(params[:id])
  end

  # POST /game_data
  # POST /game_data.json
  def create
    @game_datum = GameDatum.new(params[:game_datum])

    respond_to do |format|
      if @game_datum.save
        format.html { redirect_to @game_datum, notice: 'Game datum was successfully created.' }
        format.json { render json: @game_datum, status: :created, location: @game_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @game_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_data/1
  # PUT /game_data/1.json
  def update
    @game_datum = GameDatum.find(params[:id])

    respond_to do |format|
      if @game_datum.update_attributes(params[:game_datum])
        format.html { redirect_to @game_datum, notice: 'Game datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_data/1
  # DELETE /game_data/1.json
  def destroy
    @game_datum = GameDatum.find(params[:id])
    @game_datum.destroy

    respond_to do |format|
      format.html { redirect_to game_data_url }
      format.json { head :no_content }
    end
  end
end
