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

class GameData
    def intialize(gamdata)
        @gamdata = gamdata;
    end;
    def show_data
      @gamdata = { {:Tag=>{:Entry=>1,:User_ID=>1}}=>{:Question=>1, :Problems=>[4, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>2,:User_ID=>1}}=>{:Question=>2, :Problems=>[6, 2], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>3,:User_ID=>1}}=>{:Question=>3, :Problems=>[3, 8], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>4,:User_ID=>1}}=>{:Question=>4, :Problems=>[1, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>5,:User_ID=>1}}=>{:Question=>2, :Problems=>[5, 9], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>6,:User_ID=>1}}=>{:Question=>1, :Problems=>[8, 4], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>7,:User_ID=>1}}=>{:Question=>3, :Problems=>[3, 6], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>8,:User_ID=>2}}=>{:Question=>4, :Problems=>[3, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>9,:User_ID=>2}}=>{:Question=>3, :Problems=>[4, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>10,:User_ID=>2}}=>{:Question=>2, :Problems=>[5, 2], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>11,:User_ID=>3}}=>{:Question=>1, :Problems=>[9, 6], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>12,:User_ID=>3}}=>{:Question=>2, :Problems=>[4, 3], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>13,:User_ID=>3}}=>{:Question=>4, :Problems=>[1, 8], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>14,:User_ID=>3}}=>{:Question=>3, :Problems=>[6, 5], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>15,:User_ID=>3}}=>{:Question=>4, :Problems=>[7, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>16,:User_ID=>3}}=>{:Question=>1, :Problems=>[2, 3], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>17,:User_ID=>3}}=>{:Question=>2, :Problems=>[1, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>18,:User_ID=>3}}=>{:Question=>3, :Problems=>[8, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>19,:User_ID=>3}}=>{:Question=>1, :Problems=>[5, 3], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>20,:User_ID=>3}}=>{:Question=>2, :Problems=>[2, 9], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>21,:User_ID=>3}}=>{:Question=>1, :Problems=>[6, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>22,:User_ID=>3}}=>{:Question=>4, :Problems=>[7, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>23,:User_ID=>4}}=>{:Question=>4, :Problems=>[1, 2], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>24,:User_ID=>4}}=>{:Question=>1, :Problems=>[3, 4], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>25,:User_ID=>4}}=>{:Question=>2, :Problems=>[5, 6], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>26,:User_ID=>4}}=>{:Question=>3, :Problems=>[9, 7], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>27,:User_ID=>4}}=>{:Question=>4, :Problems=>[8, 1], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>28,:User_ID=>4}}=>{:Question=>1, :Problems=>[2, 3], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>29,:User_ID=>5}}=>{:Question=>1, :Problems=>[4, 5], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>30,:User_ID=>5}}=>{:Question=>4, :Problems=>[6, 7], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>31,:User_ID=>5}}=>{:Question=>3, :Problems=>[8, 9], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>32,:User_ID=>5}}=>{:Question=>2, :Problems=>[1, 3], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>33,:User_ID=>5}}=>{:Question=>1, :Problems=>[2, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>34,:User_ID=>5}}=>{:Question=>3, :Problems=>[5, 7], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>35,:User_ID=>5}}=>{:Question=>2, :Problems=>[6, 8], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>36,:User_ID=>5}}=>{:Question=>1, :Problems=>[9, 2], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>37,:User_ID=>5}}=>{:Question=>4, :Problems=>[1, 4], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>38,:User_ID=>5}}=>{:Question=>3, :Problems=>[2, 5], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>39,:User_ID=>5}}=>{:Question=>2, :Problems=>[3, 6], :Response=>{:Answer=>"A", :Same=>0, :Skip=>0}},
        {:Tag=>{:Entry=>40,:User_ID=>5}}=>{:Question=>1, :Problems=>[7, 9], :Response=>{:Answer=>"B", :Same=>0, :Skip=>0}} };  
    end
end

# class GameDataController #< ApplicationController
#
#    def game_data_extractor
        
        Attributes_Titles = {1=>"'Importance'",2=>"'Immediacy'",3=>"'Complexity'",4=>"'Cost'"}
        Problems = {1=>"'Proliferation of Genetically Modified Food'",2=>"'The magnitude of US debt'",3=>"'Drugs'",4=>"'Drinking and Driving'",5=>"'The lack of moral conviction in American Society'", 6=>"'The Middle Eastern Conflict'",7=>"'The increase of Greenhouse gases'",8=>"'The threat of Biological Warefare'",9=>"'Proliferation of Nuclear Weapons'"} 
        
        #THIS IS THE CODE THAT WILL CHANGE!!!
        gdata = GameData.new.show_data;
        # gdata = @GameData.all
        #THIS IS THE CODE THAT WILL CHANGE!!!

        filename_out = "extracted_data.csv"
        require 'csv'
        entries = gdata.size
        
        idata = {}
        q_temp = []
        p_temp1 = []
        p_temp2 = []
        
        gdata.values.each do |item|
            q_temp << item[:Question]
            p_temp1 << item[:Problems][0]
            p_temp1 << item[:Problems][1]
            p_temp2 << item[:Problems].sort
        end;
        
        q_set = q_temp.uniq.sort  #Define an array of the Question ID's in the subset of data chosen 
        p_set = p_temp1.uniq.sort #Define an array of the Problem ID's in the subset of data chosen
        
        avg_trials_per_pair = p_temp2.uniq.length #
        
        p_set.each do |j|
            idata = idata.merge(j => {})
        end;
        
        # TODO: Double Check this code to verify that unscoped problems initialize to mid-scale
        
        q_set.each do |i|
            p_key = Array.new(p_set.length,0) { Array.new(2,0) };
            gdata.values.each do |item|
                if item[:Question] == i
                    p_key[item[:Problems][0]-1][1] = p_key[item[:Problems][0]-1][1] + 1
                    p_key[item[:Problems][1]-1][1] = p_key[item[:Problems][1]-1][1] + 1 
                    if item[:Response][:Answer] == "A"
                        p_key[item[:Problems][0]-1][0] = p_key[item[:Problems][0]-1][0] + 1
                        p_key[item[:Problems][1]-1][0] = p_key[item[:Problems][1]-1][0] - 1
                    end
                    if item[:Response][:Answer] == "B"
                        p_key[item[:Problems][0]-1][0] = p_key[item[:Problems][0]-1][0] - 1
                        p_key[item[:Problems][1]-1][0] = p_key[item[:Problems][1]-1][0] + 1
                    end;   
                end;    
            end;
            
            hi_cnt = p_key.sort.last[0]
            offset = hi_cnt-p_key.sort.first[0]
            
            p_set.each do |k|   
                entry = 0
                if (p_key[k-1][1].to_f) != 0
                    entry = (((p_key[k-1][0].to_f)/(p_key[k-1][1].to_f))+1)/2.0
                end;
                if i==1
                    temp = idata[k]            
                    idata[k] = {i => entry}
                else 
                    temp = idata[k]            
                    idata[k] = {i => entry}.merge(temp)
                end;
            end;
        end;
        
        CSV.open("extracted_data.csv","wb") do |csv|
            csv << q_set.map{|i| Attributes_Titles[i] }
            idata.each do |k,v|    
                csv << [Problems[k]] + (q_set.map{|i| v[i] })
            end;
        end;
        
