class Array
	def counts
		inject( Hash.new(0) ){ |hash,element|
			hash[ element ] +=1
			hash
		}
	end
end
# TODO: REMOVE THE INITIALIZATION BELOW
uId = 5

@gdata_all = GameResult.all
@gdata_user = GameResult.where({:user_id => uId})

####### IDENTIFY THE BOUNDS OF THE DATASET ########    
idata = {}
questions_by_all = []
questions_by_user = []
problems_by_all = []
problems_by_user = []
pq_by_all_set = {}
pq_by_user_set = {}

@gdata_all.each do |value|
    if value.skip == false && value.same == false
        questions_by_all << value.question_id
        problems_by_all << value.issue_ids[0]
        problems_by_all << value.issue_ids[1]
        if !pq_by_all_set.has_key?(value.question_id)
            pq_by_all_set.merge!(value.question_id=>[])
        end
        pq_by_all_set[value.question_id]<<value.issue_ids.sort
    end;
end;

@gdata_user.each do |value|
    if value.skip == false && value.same == false
        questions_by_user << value.question_id
        problems_by_user << value.issue_ids[0]
        problems_by_user << value.issue_ids[1]
        if !pq_by_user_set.has_key?(value.question_id)
            pq_by_user_set.merge!(value.question_id=>[])
        end
        pq_by_user_set[value.question_id]<<value.issue_ids.sort
    end;
end;

pq_by_all_set=Hash[pq_by_all_set.sort_by{|problem, freq| freq.length}]
pq_by_user_set=Hash[pq_by_user_set.sort_by{|problem, freq| freq.length}]

problems_by_all_freq_sort = Hash[problems_by_all.counts.sort_by{|problem, freq| freq}]
questions_by_all_freq_sort = Hash[questions_by_all.counts.sort_by{|problem, freq| freq}]

problems_by_user_freq_sort_rev = Hash[problems_by_user.counts.sort_by{|problem, freq| -freq}]
questions_by_user_freq_sort = Hash[questions_by_user.counts.sort_by{|problem, freq| freq}]

p_all_max = problems_by_all.max+1
q_all_max = questions_by_all.max
p_user_num = problems_by_user.length/2

pq_by_user_set.each do |key,value|
    value.uniq!
    value.sort_by!{|a,b| a*p_all_max+b}
end
pq_by_all_set.each do |key,value|
    #value.uniq!
    value.sort_by!{|a,b| a*p_all_max+b}
end 

pq_by_all_set
pq_by_user_set
problems_by_all_freq_sort
questions_by_all_freq_sort
problems_by_user_freq_sort_rev
questions_by_user_freq_sort

# TODO: Address skip/flag?

ques_order = questions_by_all_freq_sort.map{|k,v| k}
prob_order = problems_by_user_freq_sort_rev.map{|k,v| k}
temp = problems_by_all_freq_sort.map{|k,v| k}
#TODO: Add Code here that throws out FLAGGED (SAME & SKIP?) type dudes
temp.each do |p|
    if !prob_order.include?(p)
        prob_order<<p
    end
end

#################################################################################
# This code limits the number of questions that are asked to a particular user
# based upon the number of questions that the user has answered up until this point

# Define Constants
def_priority_num_of_questions = 15
percent_weight_focus_on_completion = 0.8

q_order = questions_by_all_freq_sort.map{|k,v| Hash[k=>questions_by_user.counts[k] ]}
# If needed, we can use: q_order = Hash[Hash[q_order.map!{|k| k.flatten}].sort_by{|k,v| v}]
next_question = Hash[q_order.map!{|k| k.flatten}].min_by{|k,v| v}[0]

# TODO: Reorder some of this to only group stuff based on the "choice" variable to reduce required computation

if !pq_by_user_set[next_question] == nil
    problems_left_focus = prob_order[0..def_priority_num_of_questions].combination(2).to_a-pq_by_user_set[next_question]
    problems_left_rest_remaining = (prob_order.combination(2).to_a-pq_by_user_set[next_question])-problems_left_focus
else
    problems_left_focus = prob_order[0..def_priority_num_of_questions].combination(2).to_a
    problems_left_rest_remaining = prob_order.combination(2).to_a-problems_left_focus
end

choice = rand()+0.00000001

if choice < percent_weight_focus_on_completion && problems_left_focus.length > 0
    next_question = problems_left_focus[(choice*(1.0/percent_weight_focus_on_completion))*problems_left_focus.length-1]
elsif !problems_left_rest_remaining.length == 0
    next_question = problems_left_rest_remaining[(rand()+0.00000001)*problems_left_rest_remaining.length-1 ]
else
    next_question = prob_order.combination(2).to_a[(rand()+0.00000001)]
end

