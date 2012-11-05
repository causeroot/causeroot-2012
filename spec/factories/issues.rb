# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    problem "MyString"
    cause "MyText"
    effects "MyText"
  end
end
