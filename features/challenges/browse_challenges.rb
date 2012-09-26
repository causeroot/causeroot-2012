Feature: Browse Challenges
	This is a collection of tests that will pass with flying colors during our demo
	Background:
		Given that I am any user
		And I visit the challenges index
	Scenario: View challenge index
		Then I should see a list of challenges
	Scenario: Sort challenges
		Then I click sort by award
		Then I should see a list of challenges sorted by award in descending order
	Scenario: Search challenges
		And I enter 'NASA' into the search box
		Then I press the search button
		Then I should see a challenge with 'NASA' in the title
	Scenario: View challenge
		And I click on the "Learn More" link for the NASA challenge
		Then I should see the challenge details page for the NASA challenge
	Scenario: Pagination
		And there are more than 5 challenges in the database
		When I click on "Next" link
		Then I should see more challenges

