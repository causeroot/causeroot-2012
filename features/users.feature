Feature: Users

	Scenario: I can register
		Given that I am on the register page
		And I fill in the registration page
		Then I should see "User was successfully created."
		And I should see the button "Login"
	
	Scenario: User exists and can login
		Given that I am a valid user
		When I sign in
		Then I should see "Login successful"
		
	Scenario: User does not exist
		When I sign in
		Then I should see "Login failed"
		
	Scenario: After logout show challenges
		Given that I am logged in
		When I click the link "Logout"
		Then I should see "Logged out"
		And I should see "Listing challenges"


		

		