FactoryGirl.define do
  factory :challenge do
	  sequence(:name) {|n| "Challenge Name #{n}" }
    name generate(:challenge_title)
    url  "http://challenge.com/url"
    description Faker::Lorem.paragraphs(3)
    award "$17,000"
    deadline 1.years.from_now
    post_date 1.year.ago
    image_url "/assets/challenge.png"
    rules Faker::Lorem.paragraphs(3)
  end
end