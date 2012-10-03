include Capybara::DSL

Given /^that I am any user$/ do
	# ok
end

Given /^I visit the challenges index$/ do
  visit '/challenges'
end

Then /^I should see a list of challenges$/ do
  page.has_content('NASA: Night Rover Challenge');
  page.has_content('The Arimaa Challenge');
end

Then /^I click sort by award$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a list of challenges sorted by award in descending order$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I enter 'NASA' into the search box$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I press the search button$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a challenge with 'NASA' in the title$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I click on the "(.*?)" link for the NASA challenge$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the challenge details page for the NASA challenge$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^there are more than (\d+) challenges in the database$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I click on "(.*?)" link$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see more challenges$/ do
  pending # express the regexp above with the code you wish you had
end
