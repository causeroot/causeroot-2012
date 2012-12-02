# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:iproblem) {|n| "#{Faker::Lorem.sentence}#{n}" }

  factory :issue do
    problem { FactoryGirl.generate(:iproblem) }
    factory :issue_with_causes do
      ignore do
        cause_count 5
      end

      after_create do |user, evaluator|
        FactoryGirl.create_list(:cause, evaluator.cause_count, :user => user)
      end
    end

  end
end
