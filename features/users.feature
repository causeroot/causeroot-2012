Feature: Users
	
	Scenario: User can login
		Given that I am a valid user
		When I sign in
		Then I should see "Login successful"