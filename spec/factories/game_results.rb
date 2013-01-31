# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_result do
    user
    question
    answer 0
    same false
    skip false

    # user_with_posts will create post data after the user has been created
    factory :game_result_with_issues do
      # posts_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        problem_count 2
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |game_result, evaluator|
        #FactoryGirl.create_list(:issue, evaluator.problem_count, game_result: game_result)
        1.upto(game_result.question.problem_count) {game_result.issues << FactoryGirl.create(:issue)}
        game_result.answer = game_result.issue_ids.sample
      end
    end
  end
end
