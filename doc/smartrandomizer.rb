
module Enumerable
    def sort_distinct_by_frequency
        histogram = inject(Hash.new(0)) { |hash, x| hash[x] += 1; hash }
        histogram.keys.sort_by { |x| [histogram[x], x] }
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

#TODO: Operating system schedulers? Read up to optimize algorithm (simple)

uId = 3

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

pq_by_all_set=Hash[problems_by_all_set.sort_by{|problem, freq| freq.length}]
pq_by_user_set=Hash[problems_by_user_set.sort_by{|problem, freq| freq.length}]

problems_by_all_freq_sort = Hash[problems_by_all.counts.sort_by{|problem, freq| freq}]
questions_by_all_freq_sort = Hash[questions_by_all.counts.sort_by{|problem, freq| freq}]

problems_by_user_freq_sort_rev = Hash[problems_by_user.counts.sort_by{|problem, freq| -freq}]
questions_by_user_freq_sort = Hash[questions_by_user.counts.sort_by{|problem, freq| freq}]

p_all_max = problems_by_all.max+1
q_all_max = questions_by_all.max
p_user_num = problems_by_user.length

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
temp.each do |p|
    if !prob_order.include?(p)
        prob_order<<p
    end
end

next_question = nil
next_problems = nil
num = 1

while next_question == nil || next_problems == nil do
    #for i in 0..num  
    for q in 1..q_all_max
        prob_order[0..num].combination(2).to_a.each do |set|
            puts set
            if pq_by_user_set[ques_order[q-1]].include?(set) && next_problems == nil
                next_question = q
                next_problems = set
            end
        end  
        q = q_all_max+1
    end            
    num=num+1
    #TODO: if all are answered, then do random
end

# problems_by_all_freq_sort.each do |k,v|

# If user answers not so many questions, then what should the ALL graph show
# if all are answered, then do random

123
12 - [1-4]
13 - [1-4]
23 - [1-4]

1234
12 - [1-4]
13 - [1-4]
23 - [1-4]
14
24
34

12345
12 - [1-4]
13 - [1-4]
23 - [1-4]
14
24
34
15
25
35
45
