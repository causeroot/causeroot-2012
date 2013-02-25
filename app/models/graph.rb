require 'csv'

class Graph
    # attr_accessible :title, :body
    def self.grabdata(uId={:id=>0})
        problem_limit =  uId[:id] == 0 ? 60 : 15
        question_themes= Hash[Question.all.map{ |question| [question.id, question.name] }]
        results = Issue.all.map do |issue|
            answers = issue.game_result.select{|r| uId[:id] == 0 or r.user_id == uId[:id]}.map do |result|
                {:question_id => result.question_id, :winner => result.answer}
            end
            questions = answers.map{ |answer| answer[:question_id] }.uniq! || []
            {:problem => issue.problem,
             :count => answers.size,
             :results =>
                Hash[questions.map do |question|
                    questions_asked = answers.count { |ans| ans[:question_id] == question}
                    questions_won = answers.count { |ans| ans[:question_id] == question && ans[:winner] == issue.id}
                    score = questions_asked == 0 ?  0 : questions_won.to_f / questions_asked.to_f
                    [question_themes[question], score]
                end]
            }
        end.sort{|a,b| b[:count] <=> a[:count]}.first(problem_limit)
        hashResults = Hash[results.map{|r| [r[:problem], r[:results]]}]

        CSV.generate() do |csv|
            questions = question_themes.values.sort
            csv << ["Problem Name"] + questions
            hashResults.each do |name, scores|
                csv << ["#{name}"] + (questions.map { |question| scores[question] or 0.5 }) if scores != nil
            end
        end
    end
end

