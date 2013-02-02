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
        if value.skip == false && value.same == false
            question_temp << value.question_id
            problem_temp1 << value.issue_ids[0]
            problem_temp1 << value.issue_ids[1]
            problem_temp2 << value.issue_ids.sort
            user_temp << value.user_id
        end;
    end;
    
    module Enumerable
    def sort_distinct_by_frequency
       histogram = inject(Hash.new(0)) { |hash, x| hash[x] += 1; hash }
        histogram.keys.sort_by { |x| [histogram[x], x] }
     end
  end

problem_temp1.sort_distinct_by_frequency.first

