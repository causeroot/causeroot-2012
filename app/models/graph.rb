require 'csv'

class Graph
  # attr_accessible :title, :body
  def self.grabdata(uId=0)
    
    idata_all = {}
    repeat = 0
    
    while repeat < 2 do
    
        if repeat == 0
            @game_data = GameResult.all
        elsif repeat == 1
            @game_data = GameResult.where({:user_id => uId})
            repeat = 3
        end
    
        # num_of_entries = @game_data.size
        
    ####### IDENTIFY THE BOUNDS OF THE DATASET ########
              
        idata = {}
        question_temp = []
        problem_temp1 = []
        problem_temp2 = []
        user_temp = []
        
        @game_data.each do |value|
            if value.skip == false && value.same == false
                question_temp << value.question_id
                problem_temp1 << value.issue_ids[0]
                problem_temp1 << value.issue_ids[1]
                problem_temp2 << value.issue_ids.sort
                user_temp << value.user_id
            end
        end
    
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
        end
    
        question_set.each do |i|
            problem_key = Array.new(problem_set.length) { Array.new(2,0) };
    
<<<<<<< HEAD
            @game_data.each do |item|
                # Exclude all entries where the user skipped Q's or said they were the same
                if item.skip == false && item.same == false
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
                end
            end
    
           # boundry_case = problem_key.max_by {|a,b| [a.abs,b.abs].max}
           # offset = [boundry_case[0].abs,boundry_case[1].abs].max
           
            boundry_case_max = problem_key.max_by{|a,b| a+b}.sum
            boundry_case_min = problem_key.min_by{|a,b| a+b}.sum
            offset = boundry_case_max-boundry_case_min
=======
    # TODO(Luis): FIGURE HOW WE WOULD REALLY WANT TO USE THIS VARIABLE
    unique_pairs = problem_temp2.uniq.length #

######## CALCULATE RANKING DATA FOR ALL QUESTIONS #########
  
    problem_set.each do |j|
        # Create data arrays corresponding for each problem, where each array will have values
        # corresponding to each of questions in the question_set
        idata = idata.merge(j => {})
    end;

    question_set.each do |i|
        problem_key = Array.new(problem_set.length,0) { Array.new(2,0) };
>>>>>>> 3db04155c9b9bd5526092b8bb1e61c972304a7b9

            if repeat == 0
                problem_set.each do |k|   
                    entry = 0.5
                    #TODO: Contemplate whether we want to if NO data, for all of it to be smack at 0.5? (is it doing this already?)
                    unless offset == 0
                        entry = (problem_key[problem_set.index(k)][0].to_f+problem_key[problem_set.index(k)][1].to_f-boundry_case_min)/(offset) 
                    end
                    
                    if i==1
                        temp = idata[k]            
                        idata[k] = {i => entry}
                    else
                        temp = idata[k]            
                        idata[k] = {i => entry}.merge(temp)
                    end
                end
            elsif repeat == 3
                problem_set.each do |k|        
                    if problem_key[problem_set.index(k)] == [0,0]
                        entry = idata_all[k][i]
                    else
                        entry = (problem_key[problem_set.index(k)][0].to_f+problem_key[problem_set.index(k)][1].to_f-boundry_case_min)/(offset) 
                    end
            
                    if i==1
                        temp = idata[k]            
                        idata[k] = {i => entry}
                    else
                        temp = idata[k]            
                        idata[k] = {i => entry}.merge(temp)
                    end
                end
            end
        end
        
        if uId == 0
            repeat = 3
        elsif repeat == 0
            idata_all = idata
            repeat = 1
        end
#            repeat = 2
#        end
        
        ######### WRITE THE CALCULATED DATA TO CSV FILE ###########
        #TODO: Limit the numbers that are being written here      
    end
    
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
          csv <<  ["#{problems[k-1]}"] + (question_set.map{|i| %Q[#{v[i]}] })
      end
    end;
    
    csvstr
  end
end
