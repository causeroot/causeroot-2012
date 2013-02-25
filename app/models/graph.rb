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
    
        num_of_entries = @game_data.size
        
    ####### IDENTIFY THE BOUNDS OF THE DATASET ########
              
        idata = {}
        outdata = {}
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
        problem_set_freq_sort = problem_temp1.counts.sort_by{|k,v| v}.map{|k,v| k}



        if repeat == 0
          problem_set_freq_sort = problem_set_freq_sort[0..59].sort
        else
          problem_set_freq_sort = problem_set_freq_sort[0..14].sort
        end

        # Define an array of the User ID's in the subset of data chosen
        # user_set = user_temp.uniq.sort
        
        # TODO: FIGURE HOW WE WOULD REALLY WANT TO USE THIS VARIABLE
        # unique_pairs = problem_temp2.uniq.length #
    
    ######## CALCULATE RANKING DATA FOR ALL QUESTIONS #########
            
        # Create data arrays corresponding for each problem, where each array will have values
        # corresponding to each of questions in the question_set

        #TODO: Make it to the max number here!!!
        problem_set.each do |j|
            idata = idata.merge(j => {})
            question_set.each do |q|
                if q==question_set.first          
                    idata[j] = {q => [0,0]}
                else
                    temp = idata[j]            
                    idata[j] = {q => [0,0]}.merge(temp)
                end
            end
        end

        @game_data.each do |item|
            if item.skip == false && item.same == false
                if item.answer == item.issue_ids[0]
                    idata[item.issue_ids[0]][item.question_id][0] = idata[item.issue_ids[0]][item.question_id][0]+1
                    idata[item.issue_ids[0]][item.question_id][1] = idata[item.issue_ids[0]][item.question_id][1]+1
                    idata[item.issue_ids[1]][item.question_id][0] = idata[item.issue_ids[1]][item.question_id][0]-1
                    idata[item.issue_ids[1]][item.question_id][1] = idata[item.issue_ids[1]][item.question_id][1]+1                  
                elsif item.answer == item.issue_ids[1] 
                    idata[item.issue_ids[1]][item.question_id][0] = idata[item.issue_ids[1]][item.question_id][0]+1
                    idata[item.issue_ids[1]][item.question_id][1] = idata[item.issue_ids[1]][item.question_id][1]+1               
                    idata[item.issue_ids[0]][item.question_id][0] = idata[item.issue_ids[0]][item.question_id][0]-1
                    idata[item.issue_ids[0]][item.question_id][1] = idata[item.issue_ids[0]][item.question_id][1]+1
                end
            end
        end


        problem_set.each do |prob|
            question_set.each do |quest|
                if idata[prob][quest][1].to_f == 0.0
                    if repeat == 0
                        idata[prob][quest] = 0.5
                    else
                        idata[prob][quest] = idata_all[prob][quest]
                    end
                else
                    idata[prob][quest] = idata[prob][quest][0].to_f/(idata[prob][quest][1].to_f*2)+0.5
                end
            end
        end
        
        if uId == 0
            repeat = 3
        elsif repeat == 0
            repeat = 1
            idata_all = idata
        end 
    end

    problems = []

    problem_set_freq_sort.each do |entry|
      outdata[entry] = idata[entry]
      problems << Issue.find(entry).problem
    end;

        ####### WRITE THE CALCULATED DATA TO CSV FILE ###########
    
    question_Themes = []
    
    # TODO questions = Question.all
    questions = YAML::load_file('db/questions.yml')
    questions.values.each do |q|
        question_Themes << q['name']
    end;

    csvstr = CSV.generate() do |csv|
      csv << ["Problem Name"] + question_set.map{|i| question_Themes[i-1] }
      outdata.each do |k,v|
          csv <<  ["#{problems[problem_set_freq_sort.index(k)]}"] + (question_set.map{|i| %Q[#{v[i]}] })
      end
    end;
    
    csvstr
  end
end

class Array
  def counts
    inject( Hash.new(0) ){ |hash,element|
      hash[ element ] +=1
      hash
    }
  end
end