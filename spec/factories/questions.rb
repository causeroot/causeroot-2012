# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:qname) {|n| "#{Faker::Lorem.sentence}#{n}" }
  sequence(:qq) {|n| "#{Faker::Lorem.paragraph}#{n}" }
  factory :question do
    question { FactoryGirl.generate(:qq) }
    name { FactoryGirl.generate(:qname) }
    problem_count 2
  end
end
