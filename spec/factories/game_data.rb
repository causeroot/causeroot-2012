# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_datum do
    user
    question
    response
  end
end

