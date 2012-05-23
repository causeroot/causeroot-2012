class ScrapersController < ApplicationController
  # GET /scrapers
  # GET /scrapers.json
  def index
    @scrapers = Scraper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scrapers }
    end
  end

  # GET /scrapers/1
  # GET /scrapers/1.json
  def show
    @scraper = Scraper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scraper }
    end
  end

  # GET /scrapers/new
  # GET /scrapers/new.json
  def new
    @scraper = Scraper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scraper }
    end
  end

  # GET /scrapers/1/edit
  def edit
    @scraper = Scraper.find(params[:id])
  end

  # POST /scrapers
  # POST /scrapers.json
  def create
    @scraper = Scraper.new(params[:scraper])

    respond_to do |format|
      if @scraper.save
        format.html { redirect_to @scraper, notice: 'Scraper was successfully created.' }
        format.json { render json: @scraper, status: :created, location: @scraper }
      else
        format.html { render action: "new" }
        format.json { render json: @scraper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scrapers/1
  # PUT /scrapers/1.json
  def update
    @scraper = Scraper.find(params[:id])

    respond_to do |format|
      if @scraper.update_attributes(params[:scraper])
        format.html { redirect_to @scraper, notice: 'Scraper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scraper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrapers/1
  # DELETE /scrapers/1.json
  def destroy
    @scraper = Scraper.find(params[:id])
    @scraper.destroy

    respond_to do |format|
      format.html { redirect_to scrapers_url }
      format.json { head :no_content }
    end
  end
end
