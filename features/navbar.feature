Feature: navbar
	The nav bar is on almost every page. These tests will ensure that is works from the front page. 
	
	Background:
		Given that I am on the main page
		
	Scenario: navbar is visible
		Then I should see the link "Demo"
		And I should see the link "Challenges"
		And I should see the link "About Us"
	
	Scenario:	about us
		And I click on "About Us"
		Then I should read about a group of passionate individuals
	
	Scenario: demo
		And I click on "Demo"
		Then I should see a youtube video
		
	Scenario: challenges
		And I click on "Challenges"
		Then I should see "Listing challenges"
		
	Scenario: new challenge
		Given that I am logged in
		And I click on "Create New Challenge"
		Then I should see "New Challenge"
