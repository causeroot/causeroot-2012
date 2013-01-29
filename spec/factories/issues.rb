# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:iproblem) {|n| "#{Faker::Lorem.sentence}#{n}" }

  factory :issue do
    problem { FactoryGirl.generate(:iproblem) }
  end
end
