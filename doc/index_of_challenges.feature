@aggregate @front_end_user @challenge_index_page
Feature: Index of challenges

	Scenario: User arrives at the index of challenge page
		Given the user is at the first page of viewable challenges
		Then the available challenges objects are displayed correctly
		And there is no string in the search string text box
		And the pagination links reflect the number of viewable pages
		And there exists a link to the about us page
		And there is a link to sort by title
		And there is a link to sort by award
		And there is a link to sort by deadline
		And there is a link to sort by start date
	
	
	Sc
	
		arrival / what i see
		pagination
		sort
		search
		click into view challenge information
