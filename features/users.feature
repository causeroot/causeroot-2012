Feature: Users
	
	Scenario: User exists and can login and logout
		Given that I am a valid user
		When I sign in
		Then I should see "Login successful"
		When I click the link "Logout"
		Then I should see "Logged out"
		
	Scenario: User does not exist
		When I sign in
		Then I should see "Login failed"
		