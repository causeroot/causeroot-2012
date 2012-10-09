Given /^that I am on the main page$/ do
  visit '/'
end

Then /^I should see the link "(.*?)"$/ do |link_text|
  page.should have_content link_text
end

Given /^I click on "(.*?)"$/ do |link_text|
  click_link link_text
end

Then /^I should read about a group of passionate individuals$/ do
  page.should have_content "group of passionate individuals"
end

Then /^I should see a youtube video$/ do
  page.has_xpath? './/embed[@id="video-player-flash"]'
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content text
end

Given /^that I am logged in$/ do
  pending # express the regexp above with the code you wish you had
end
