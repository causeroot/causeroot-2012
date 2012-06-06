class DrilldownRulesController < ApplicationController
  # GET /drilldown_rules
  # GET /drilldown_rules.json
  def index
    @drilldown_rules = DrilldownRule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drilldown_rules }
    end
  end

  # GET /drilldown_rules/1
  # GET /drilldown_rules/1.json
  def show
    @drilldown_rule = DrilldownRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @drilldown_rule }
    end
  end

  # GET /drilldown_rules/new
  # GET /drilldown_rules/new.json
  def new
    @drilldown_rule = DrilldownRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @drilldown_rule }
    end
  end

  # GET /drilldown_rules/1/edit
  def edit
    @drilldown_rule = DrilldownRule.find(params[:id])
  end

  # POST /drilldown_rules
  # POST /drilldown_rules.json
  def create
    @drilldown_rule = DrilldownRule.new(params[:drilldown_rule])

    respond_to do |format|
      if @drilldown_rule.save
        format.html { redirect_to @drilldown_rule, notice: 'Drilldown rule was successfully created.' }
        format.json { render json: @drilldown_rule, status: :created, location: @drilldown_rule }
      else
        format.html { render action: "new" }
        format.json { render json: @drilldown_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /drilldown_rules/1
  # PUT /drilldown_rules/1.json
  def update
    @drilldown_rule = DrilldownRule.find(params[:id])

    respond_to do |format|
      if @drilldown_rule.update_attributes(params[:drilldown_rule])
        format.html { redirect_to @drilldown_rule, notice: 'Drilldown rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @drilldown_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drilldown_rules/1
  # DELETE /drilldown_rules/1.json
  def destroy
    @drilldown_rule = DrilldownRule.find(params[:id])
    @drilldown_rule.destroy

    respond_to do |format|
      format.html { redirect_to drilldown_rules_url }
      format.json { head :no_content }
    end
  end
end
