# This will guess the User class
FactoryGirl.define do
  factory :site do
    name "Testing Site"
    url_id
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
    admin      true
  end
end