# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
		sequence(:username) {|n| "testuser#{n}" }
		email { "#{username}@causeroot.org"	}
		password "secret88"
		password_confirmation { "#{password}" }
  end
end
