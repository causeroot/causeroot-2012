class IterateRulesController < ApplicationController
  # GET /iterate_rules
  # GET /iterate_rules.json
  def index
    @iterate_rules = IterateRule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @iterate_rules }
    end
  end

  # GET /iterate_rules/1
  # GET /iterate_rules/1.json
  def show
    @iterate_rule = IterateRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @iterate_rule }
    end
  end

  # GET /iterate_rules/new
  # GET /iterate_rules/new.json
  def new
    @iterate_rule = IterateRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @iterate_rule }
    end
  end

  # GET /iterate_rules/1/edit
  def edit
    @iterate_rule = IterateRule.find(params[:id])
  end

  # POST /iterate_rules
  # POST /iterate_rules.json
  def create
    @iterate_rule = IterateRule.new(params[:iterate_rule])

    respond_to do |format|
      if @iterate_rule.save
        format.html { redirect_to @iterate_rule, notice: 'Iterate rule was successfully created.' }
        format.json { render json: @iterate_rule, status: :created, location: @iterate_rule }
      else
        format.html { render action: "new" }
        format.json { render json: @iterate_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /iterate_rules/1
  # PUT /iterate_rules/1.json
  def update
    @iterate_rule = IterateRule.find(params[:id])

    respond_to do |format|
      if @iterate_rule.update_attributes(params[:iterate_rule])
        format.html { redirect_to @iterate_rule, notice: 'Iterate rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @iterate_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iterate_rules/1
  # DELETE /iterate_rules/1.json
  def destroy
    @iterate_rule = IterateRule.find(params[:id])
    @iterate_rule.destroy

    respond_to do |format|
      format.html { redirect_to iterate_rules_url }
      format.json { head :no_content }
    end
  end
end
