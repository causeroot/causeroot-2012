# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'foobar'
    password_confirmation 'foobar'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
