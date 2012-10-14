Given /^that I am a valid user$/ do
	visit '/signup'
	fill_in 'Username', :with => "cucumber"
	fill_in 'Email', :with => "cucmber@causeroot.org"
	fill_in 'Password', :with => "secret"
  click_button 'Create User'
  page.should have_content "User was successfully created"
end

When /I sign in/ do
	visit '/login'
	fill_in 'username', :with => "cucumber"
	fill_in 'password', :with => "secret"
  click_button 'Login'
end
