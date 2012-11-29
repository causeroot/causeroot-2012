# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    question "Is MyString a problem?"
    name "Stringage"
    prob_count 1
  end
end
