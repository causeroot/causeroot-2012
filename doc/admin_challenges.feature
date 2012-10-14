Feature: Admin Challenges
	An admin user should be able to edit, modify, and soft delete challenges.
	
		Background:
			Given that I am an admin user
			And I visit the challenges index

		Scenario: Edit Challenge
			And I click on the "Edit" link for the NASA challenge
			Then I should see the challenge details page for the NASA challenge

		Scenario: Edit Challenge
			And I click on the "Edit" link for the NASA challenge
			Then I should see the challenge details page for the NASA challenge
