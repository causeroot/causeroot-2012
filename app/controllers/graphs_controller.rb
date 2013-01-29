require 'csv'

class GraphsController < ApplicationController
  # GET /graphs
  # GET /graphs.json
  def index
    #@graphs = Graph.all

    @game_data = GameResult.all

    filename_out = "extracted_data.csv"
    num_of_entries = @game_data.size
    
####### IDENTIFY THE BOUNDS OF THE DATASET ########
          
    idata = {}
    question_temp = []
    problem_temp1 = []
    problem_temp2 = []
    user_temp = []
    
    @game_data.each do |value|
        if value.skip == nil || value.same == nil
            question_temp << value.question_id
            problem_temp1 << value.issue_ids[0]
            problem_temp1 << value.issue_ids[1]
            problem_temp2 << value.issue_ids.sort
            user_temp << value.user_id
        end;
    end;
    
    # Define an array of the Question ID's in the subset of data chosen 
    question_set = question_temp.uniq.sort  
    
    # Define an array of the Problem ID's in the subset of data chosen
    problem_set = problem_temp1.uniq.sort
    
    # Define an array of the User ID's in the subset of data chosen
    user_set = user_temp.uniq.sort
    
    # TODO: FIGURE HOW WE WOULD REALLY WANT TO USE THIS VARIABLE
    unique_pairs = problem_temp2.uniq.length #

######## CALCULATE RANKING DATA FOR ALL QUESTIONS #########
  
    problem_set.each do |j|
        # Create data arrays corresponding for each problem, where each array will have values
        # corresponding to each of questions in the question_set
        idata = idata.merge(j => {})
    end;

    question_set.each do |i|
        problem_key = Array.new(problem_set.length,0) { Array.new(2,0) };

        @game_data.each do |item|
            # Exclude all entries where the user skipped Q's or said they were the same
            if item.skip == nil || item.same == nil
                if item.question_id == i
                    #problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]+1
                    #problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]+1 
                    
                    if item.answer == item.issue_ids[0]
                        problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]+1
                        problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]-1
                    end
                    if item.answer == item.issue_ids[1]
                        problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]-1
                        problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]+1
                    end  
                end
            end;
        end;

        boundry_case = problem_key.max_by {|a,b| [a.abs,b.abs].max}
        offset = [boundry_case[0].abs,boundry_case[1].abs].max
        
        problem_set.each do |k|   
            entry = 0.0
            entry = (problem_key[problem_set.index(k)][0].to_f+problem_key[problem_set.index(k)][1].to_f )/(offset*2) + 0.5
            if i==1
                temp = idata[k]            
                idata[k] = {i => entry}
            else 
                temp = idata[k]            
                idata[k] = {i => entry}.merge(temp)
            end;
        end;
    end;

######### WRITE THE CALCULATED DATA TO CSV FILE ###########
    #TODO: Limit the numbers that are being written here
    
    question_Themes = []
    
    # TODO questions = Question.all
    questions = YAML::load_file('db/questions.yml')
    questions.values.each do |q|
        question_Themes << q['name']
    end;
    
    problems = []
    
    Issue.uniq.each do |i|
        problems << i.problem
    end;

    csvstr = CSV.generate() do |csv|

      csv << ["Problem Name"] + question_set.map{|i| question_Themes[i-1] }
      idata.each do |k,v|    
          #csv << [problems[k-1]] + (question_set.map{|i| v[i].to_s })
          csv <<  ["#{problems[k-1]}"] + (question_set.map{|i| %Q[#{v[i]}] })
      end
    end
        
    respond_to do |format|
#      format.html # index.html.erb
      format.json { render json: @graphs }
      format.csv { send_data csvstr }
    end
  end
end

#!/usr/bin/env ruby

# Question Type
# One or More Problems being discussed (1-3)
# The answer to the question
# 
# Similarity Button: (if so, which is the better problem statement?)
#
# Section 1: Problem Comparison Questions 
# 1 - Which is more important to you?
# 2 - Which is more of immediate concern to you?
# 3 - Which of these do you believe is a more complex problem?
# 4 - Which of these do you believe will cost more to address?
#
# Section 2:  Issue Data Verification
# 7 - Does this (A) cause (B)?
# 8 - Is (A) and effect of (B)
# 9 - Which of these two causes has a greater affect on Problem (A)?
# 10 - Which of these is a more significant effect of Problem (A)?
#
# Section 3: Matching elements from different submitted issues
# 13 - Does one of these elements affect the other? (<-, ->, No)
# 14 - Is this a problem?
# 
# UserID = int[0:X]
# QuestionFlavor = int[0:15]
# Response = int[0:3]
# Same = int[0:1]
# Skip = int[0:1]
# Prob_A = int[0:X]
# Prob_B = int[0:X]
# Prob_C = int[0:X]
#
# [UserID, QuestionFlavor, Response, Same, Skip, Prob_A, Prob_B, Prob_C]
# First Run through
# Only Q's 1-4
# No Same
# No Skip
# No Prob C (putting rand in there now - can likely take out and reduce)

# class GameData
#     def intialize(gamdata)
#         @gamdata = gamdata;
#     end;
#     def show_data
#       @gamdata = { {:Tag=>{:Entry=>1,:User_ID=>1}}=>{:Question=>1, :Problems=>[4, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>2,:User_ID=>1}}=>{:Question=>2, :Problems=>[6, 2], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>3,:User_ID=>1}}=>{:Question=>3, :Problems=>[3, 8], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>4,:User_ID=>1}}=>{:Question=>4, :Problems=>[1, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>5,:User_ID=>1}}=>{:Question=>2, :Problems=>[5, 9], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>6,:User_ID=>1}}=>{:Question=>1, :Problems=>[8, 4], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>7,:User_ID=>1}}=>{:Question=>3, :Problems=>[3, 6], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>8,:User_ID=>2}}=>{:Question=>4, :Problems=>[3, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>9,:User_ID=>2}}=>{:Question=>3, :Problems=>[4, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>10,:User_ID=>2}}=>{:Question=>2, :Problems=>[5, 2], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>11,:User_ID=>3}}=>{:Question=>1, :Problems=>[9, 6], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>12,:User_ID=>3}}=>{:Question=>2, :Problems=>[4, 3], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>13,:User_ID=>3}}=>{:Question=>4, :Problems=>[1, 8], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>14,:User_ID=>3}}=>{:Question=>3, :Problems=>[6, 5], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>15,:User_ID=>3}}=>{:Question=>4, :Problems=>[7, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>16,:User_ID=>3}}=>{:Question=>1, :Problems=>[2, 3], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>17,:User_ID=>3}}=>{:Question=>2, :Problems=>[1, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>18,:User_ID=>3}}=>{:Question=>3, :Problems=>[8, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>19,:User_ID=>3}}=>{:Question=>1, :Problems=>[5, 3], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>20,:User_ID=>3}}=>{:Question=>2, :Problems=>[2, 9], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>21,:User_ID=>3}}=>{:Question=>1, :Problems=>[6, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>22,:User_ID=>3}}=>{:Question=>4, :Problems=>[7, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>23,:User_ID=>4}}=>{:Question=>4, :Problems=>[1, 2], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>24,:User_ID=>4}}=>{:Question=>1, :Problems=>[3, 4], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>25,:User_ID=>4}}=>{:Question=>2, :Problems=>[5, 6], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>26,:User_ID=>4}}=>{:Question=>3, :Problems=>[9, 7], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>27,:User_ID=>4}}=>{:Question=>4, :Problems=>[8, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>28,:User_ID=>4}}=>{:Question=>1, :Problems=>[2, 3], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>29,:User_ID=>5}}=>{:Question=>1, :Problems=>[4, 5], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>30,:User_ID=>5}}=>{:Question=>4, :Problems=>[6, 7], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>31,:User_ID=>5}}=>{:Question=>3, :Problems=>[8, 9], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>32,:User_ID=>5}}=>{:Question=>2, :Problems=>[1, 3], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>33,:User_ID=>5}}=>{:Question=>1, :Problems=>[2, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>34,:User_ID=>5}}=>{:Question=>3, :Problems=>[5, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>35,:User_ID=>5}}=>{:Question=>2, :Problems=>[6, 8], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>36,:User_ID=>5}}=>{:Question=>1, :Problems=>[9, 2], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>37,:User_ID=>5}}=>{:Question=>4, :Problems=>[1, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>38,:User_ID=>5}}=>{:Question=>3, :Problems=>[2, 5], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>39,:User_ID=>5}}=>{:Question=>2, :Problems=>[3, 6], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
#         {:Tag=>{:Entry=>40,:User_ID=>5}}=>{:Question=>1, :Problems=>[7, 9], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}} };  
#     end
# end

# class GameDataController #< ApplicationController
#
#    def @game_data_extractor
        
