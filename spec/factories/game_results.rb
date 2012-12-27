# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_result do
    user
    question
    answer 1
    same false
    skip false
    factory :game_result_with_issues do
      ignore do
        issue_count 2
      end

      after_create do |game_result, evaluator|
        FactoryGirl.create_list(:issue, evaluator.issue_count, :game_result => game_result)
      end
    end
  end
end
