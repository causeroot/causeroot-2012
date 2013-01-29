require 'csv'

class Graph
  # attr_accessible :title, :body
  def self.grabdata(uId=0)
    
    if uId == 0
        @game_data = GameResult.all
    else
        @game_data = GameResult.where({:user_id => uId})
    end;
    
    # filename_out = "extracted_data.csv"
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
    end;
    
    csvstr
  end
end
