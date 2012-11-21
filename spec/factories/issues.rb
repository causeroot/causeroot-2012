# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    problem "MyText"
    cause_id 1
    effect_id 1
  end
end
