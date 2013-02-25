require 'csv'

class Graph


    # attr_accessible :title, :body
    def self.grabdata(uId={:id=>0})
        problem_limit = 20
        question_themes= Hash[Question.all.map do |question|
            [question.id, question.name]
        end]

        results = Issue.all.map do |issue|
            answers = issue.game_result.select{|r| uId[:id] == 0 or r.user_id == uId[:id]}.map do |result|
                {:question_id => result.question_id, :winner => result.answer}
            end
            questions = answers.map do |answer|
                answer[:question_id]
            end.uniq!
            {:problem => issue.problem, :count => answers.size, :results =>
                if questions == nil
                    nil
                else
                    Hash[questions.map do |question|
                        questions_asked = answers.count { |ans| ans[:question_id] == question}
                        questions_won = answers.count { |ans| ans[:question_id] == question && ans[:winner] == issue.id}
                        if questions_asked == 0
                            score = 0
                        else
                            score = questions_won.to_f / questions_asked.to_f
                        end
                        [question_themes[question], score]
                    end]
                end
            }
        end.sort{|a,b| b[:count] <=> a[:count]}.first(problem_limit)
        hashResults = Hash[results.map{|r| [r[:problem], r[:results]]}]

        csvstr = CSV.generate() do |csv|
            q = question_themes.values.sort
            csv << ["Problem Name"] + q
            hashResults.each do |name, scores|
                if scores != nil
                    csv << ["#{name}"] + (q.map{|question| scores[question] or 0.5})
                end
            end
        end;
        csvstr
    end
end

