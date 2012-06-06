class PopulateRulesController < ApplicationController
  # GET /populate_rules
  # GET /populate_rules.json
  def index
    @populate_rules = PopulateRule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @populate_rules }
    end
  end

  # GET /populate_rules/1
  # GET /populate_rules/1.json
  def show
    @populate_rule = PopulateRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @populate_rule }
    end
  end

  # GET /populate_rules/new
  # GET /populate_rules/new.json
  def new
    @populate_rule = PopulateRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @populate_rule }
    end
  end

  # GET /populate_rules/1/edit
  def edit
    @populate_rule = PopulateRule.find(params[:id])
  end

  # POST /populate_rules
  # POST /populate_rules.json
  def create
    @populate_rule = PopulateRule.new(params[:populate_rule])

    respond_to do |format|
      if @populate_rule.save
        format.html { redirect_to @populate_rule, notice: 'Populate rule was successfully created.' }
        format.json { render json: @populate_rule, status: :created, location: @populate_rule }
      else
        format.html { render action: "new" }
        format.json { render json: @populate_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /populate_rules/1
  # PUT /populate_rules/1.json
  def update
    @populate_rule = PopulateRule.find(params[:id])

    respond_to do |format|
      if @populate_rule.update_attributes(params[:populate_rule])
        format.html { redirect_to @populate_rule, notice: 'Populate rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @populate_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /populate_rules/1
  # DELETE /populate_rules/1.json
  def destroy
    @populate_rule = PopulateRule.find(params[:id])
    @populate_rule.destroy

    respond_to do |format|
      format.html { redirect_to populate_rules_url }
      format.json { head :no_content }
    end
  end
end
