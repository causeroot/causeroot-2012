# This is a collection of scenarios that govern the front end user interface of the aggregator

#############################################################################		
#                     CHALLENGE OBJECT: DEFINITION                          #
#############################################################################

@aggregate @front_end_user @challenge_index_page
Feature: Challenge object definition
             
# TODO: Add Scenario: Test sorting and string filter together
# TODO: Add Scenario: Going back and forth in instances to make sure filtering is retained when "going back" 

# TODO: Define if there is any entrance criteria of prior sorting knowledge that we may want to maintain
# TODO: Re-label Feature note text
# TODO: Add specific tests with each values to test ascending/descending for each sorter function
# TODO: For the string search test, fix this so we check order by the challenge titles that happen to be (not order specific)
# TODO: For the heading to an individual challenge, fix this so we check order by the challenge titles (not order specific)
# TODO: fix redundancy for individual challenge definition


Background:
    Given the user is at the general challenges index page
    And there is a challenge object on that index page
    
    Scenario: Challenge object is correctly represented
        Given a challenge object is displayed
        Then the title for the challenge object is displayed
        And the award for the challenge object is displayed
        And the deadline for the challenge object is displayed
        And the description for the challenge object is displayed
        And the image for the challenge object is displayed
        And there is a link to the individual challenge page
            
# TEST NOTE: Make a step of the above  

#############################################################################		
#              CHALLENGES INDEX PAGE: GENERAL DEFINITION                    #
#############################################################################

@aggregate @front_end_user @challenge_index_page
Feature: General challenges index definition

	Scenario: General landing page
	    Given the user is at the first page of viewable challenges
        Then the available challenges objects are displayed correctly
		And there is no string in the search string text box
		And the pagination links reflect the number of viewable pages
	    And there exists a link to the about us page
	    And there is a link to sort by title
        And there is a link to sort by award
        And there is a link to sort by deadline
        And there is a link to sort by start date

# TEST NOTE: Make a step of the above
        
#############################################################################		
#                          DEFAULT LANDING PAGE                             #
#############################################################################

@aggregate @front_end_user @challenge_index_page
Feature: default challenge index page

The default challenge index page shall be the landing page for this site

    Scenario:
        Given the user is at the default challenges index page	
        Then the challenges objects are sorted by deadline in descending order

#############################################################################		
#                    INDIVIDUAL CHALLENGE PAGE: DEFINITION                   #
#############################################################################

Feature: Individual Challenge page definition

    Scenario: Individual Challenge page
        Given the user is at an individual challenge page
        Then there is a title displayed for challenge object
        And there is an award displayed for challenge object
        And there is a deadline displayed for the challenge object
        And there is a post date displayed for the challenge object
        And there is a description displayed for the challenge object
        And there is a rules section displayed for the challenge object
        And there is at least one url displayed for the challenge object
        And there is an image displayed that relates to the challenge object
        And there is a link to email the challenge page data
        And there is a link to post this challenge page to facebook
        And there is a link to post this challenge to a twitter
        And there is a ink to return to the challenge index
        And there is a link to the about us page
            
# TEST NOTE: Make a step of the above
 
#############################################################################		
#                        ABOUT US PAGE: DEFINITION                          #
#############################################################################

@aggregate @front_end_user @about_us_page
Feature: About us page definition
                 
	Scenario: About us page
	    Given the user is at the about us page
        Then there a button to go to the challenge index page
        And there is a button to message the site admins
        And there is the project misson statement
        And there is at least one graphic

# TEST NOTE: Make a step of the above 

#############################################################################		
#                  CHALLENGES INDEX PAGE: ACTIONS                           #
#############################################################################

@aggregate @front_end_user @challenge_index_page
Feature: Actions on challenges index page

Background:
    Given the user is at the general challenges index page
		
	Scenario Outline: Sort challenges
		Given the present order was "<old_order>"
		And the user clicks sort by "<parameter>"
		And the new order is "<new_order>"
		Then the list of challenges is correctly sorted
		And the user is at the first page of viewable challenges
	
# TEST NOTE: For each example, compare the first challenge with the second, the 
#            last against the second to last, and the tenth against the eleventh
#            to verify correct order is in place.
	
	    Examples: These examples should work
	        | old_order     | parameter     | order         | 
	        | descending    | title         | ascending     | 
	        | ascending     | title         | descending    | 
	        | descending    | award         | ascending     | 
	        | ascending     | award         | descending    |
	        | descending    | deadline      | ascending     |
	        | ascending     | deadline      | descending    |
	        | descending    | start date    | ascending     |
	        | ascending     | start date    | descending    |
	        
	    Examples: These examples are expected to fail
	        | old_order     | parameter     | order         | 
	        | ascending     | title         | ascending     | 
	        | descending    | title         | descending    | 
	        | ascending     | award         | ascending     | 
	        | descending    | award         | descending    |
	        | ascending     | deadline      | ascending     |
	        | descending    | deadline      | descending    |
	        | ascending     | start date    | ascending     |
	        | descending    | start date    | descending    |
	        
# TODO: Think about if the "start range"/"award range"/"end range" sorting option is preferred here at this point

# TEST NOTE: Make a step of the above

	Scenario Outline: String search challenges
		Given the loaded database in use is "<db>"
		# Test dependent
		And the user enters "<keyword>" into the search box
		And the user clicks the search button
		Then the viewable challenges all contain "<keyword>" in at least one of their fields
		And there are now "<this_many>" viewable challenges
		And the "<keyword>" string should remain in the search box
		And the pagination links reflect the number of viewable pages
		And the user should see a button that remove the string search filter
		
		Examples: Database 1 that should work
	        | db    | keyword    | challenge_title_1    |
	        | 1     | NASA       | 2                    |
	        | 1     | Millenium  | 6                    |
	        | 1     | sexfoot    | 0                    |
	        | 1     | sexfoot    | 0                    |
	        | 1     | sexfoot    | 0                    |	        	        
	        | 1     | sexfoot    | 0                    |
	        | 1     | sexfoot    | 0                    |

	    Examples: Database 2 that should work
	        | db    | keyword    | this_many    |
	        | 2     | NASA       | 2            |
	        | 2     | Millenium  | 6            |
	        | 2     | sexfoot    | 0            |
	        | 2     | sexfoot    | 0            |
	        | 2     | sexfoot    | 0            |	        	        
	        | 2     | sexfoot    | 0            |
	        | 2     | sexfoot    | 0            |
	    
	    Examples: Database 3 that should work
	        | db    | keyword    | this_many    |
	        | 3     | NASA       | 2            |
	        | 3     | Millenium  | 6            |
	        | 3     | sexfoot    | 0            |
	        | 3     | sexfoot    | 0            |
	        | 3     | sexfoot    | 0            |	        	        
	        | 3     | sexfoot    | 0            |
	        | 3     | sexfoot    | 0            |
	        
	    Examples: Databases 1-3 that are expected to fail
	        | db    | sexfoot    | this_many    |
	        | 1     | sexfoot    | 2            |
	        | 1     | sexfoot    | 6            |
	        | 1     | sexfoot    | 0            |
	        | 2     | sexfoot    | 0            |
	        | 2     | sexfoot    | 0            |	
	        | 2     | sexfoot    | 0            |	        	        
	        | 3     | sexfoot    | 0            |        	        
	        | 3     | sexfoot    | 0            |
	        | 3     | sexfoot    | 0            |
	        
# TODO: Make better examples here when we learn more
# TEST NOTE: Make a step of the above
	        
	Scenario: Return to full challenge index after string searching challenges
		Given there is a string search filter on the displayed challenges
		And the user clicks on the button to remove the string search filter
		Then the pagination links reflect the number of viewable pages
		And the user should not see a button that remove the string search filter
		And the search box should contain no strings

# TEST NOTE: Make a step of the above

	Scenario Outline: View individual challenge
	
# TEST NOTE: Max indicates the number of active challenges in the database
	
		Given the loaded database in use is "<db>"
		# Test dependent
		And the user clicks on the individual challenge link for the "<chosen>" challenge
		Then the user is at an individual challenge page for the "<chosen>" challenge
		
	    Examples: Database 1
	        | db    | challenge_title   |
	        | 1     | 1         |
	        | 1     | 2         |
	        | 1     | 10        |
	        | 1     | 11        |
	        | 1     | max-1     |
	        | 1     | max       |
	        
	    Examples: Database 2
	        | db    | chosen    |
	        | 2     | 1         |
	        | 2     | 2         |
	        | 2     | 10        |
	        | 2     | 11        |
	        | 2     | max-1     |
	        | 2     | max       |

	    Examples: Database 3
	        | db    | chosen    |
	        | 3     | 1         |
	        | 3     | 2         |
	        | 3     | 10        |
	        | 3     | 11        |
	        | 3     | max-1     |
	        | 3     | max       |

# TODO: Make better examples here when we learn more
# TEST NOTE: Make a step of the above

    Scenario: Individual challenge page landing
        Given the user is at an individual challenge page
        Then there exists a hyperlink to the URL in the URL parameter
        And there exists a link to email the challenge page data
        And there exists a link to post this challenge page to facebook
        And there exists a link to post this url to twitter
        And there exists a link to return to the challenge index
        And there exists a link to the about us page	 
	
	Scenario: Correct display of pagination
		Given the loaded database in use is "<db>"
		# Test dependent
		And the user is at challenge index page "<page_number>"
		And the previous button is "<prev_button>"  
		And the square 1 button is "<sq_1>"
		And the square 2 button is "<sq_2>"
		And the square 3 button is "<sq_3>"
		And the square 4 button is "<sq_4>"
		And the square 5 button is "<sq_5>"
		And the next button is "<next_button>"  
		Then the user clicks on the "<clicked_button>"
		And the user is at challenge index page "<new_page_number>"
		And the previous button is "<prev_button>" 
		And the new square 1 button is "<new_sq_1>"
		And the new square 2 button is "<new_sq_2>"
		And the new square 3 button is "<new_sq_3>"
		And the new square 4 button is "<new_sq_4>"
		And the new square 5 button is "<new_sq_5>"
		And the next button is "<next_button>"  
				
		Example: 
		    | db    | page_number   | prev_button   | sq_1      | sq_2      | sq_3      | sq_4      | sq_5      | next_button   | clicked_button    | new_page_number   | sq_1      | sq_2      | sq_3      | sq_4      | sq_5      |
		    | 1     | 1             | not_there     | there     |           | 
		
# TODO: Make better examples here when we learn more
# TEST NOTE: Make a step of the above
   
#############################################################################		
#                   INDIVIDUAL CHALLENGE PAGE: ACTIONS                      #
#############################################################################


Feature: Actions on individual challenge page

Background:
    Given the user is at an individual challenge page
    
    Scenario: Emailing the individual challenge data
        Given the user clicks the link to email the challenge page data
        Then the users default email client opens a new email to compose
        And the challenge page data text is pasted into the new email draft
# TODO: More data likely needed here for definition

    Scenario: Posting a link to this challenge page on facebook
        Given the user clicks the link to post this challenge page to facebook
        Then the users facebook account is opened 
        And a draft post is created to post the challenge data and URL to their wall
# TODO: More data likely needed here for definition

    Scenario: Posting a link to this challenge page on twitter
        Given the user clicks the link to post this url to twitter
        Then the users twitter program is opened
        And a new tweet is drafted
        And the challenge title and URL is posted in the drafted tweet
# TODO: More data likely needed here for definition        
        
    Scenario: Return to the Challenge Index
        Given the user clicks the link to return to the challenge index
        Then the user is at the default challenge index page
        
# TODO: Resolve whether we go to the default page with noted caveats or one of possible challenge index pages
        
    Scenario: Individual challenge landing page to about us page
        Given the user clicks the link to the about us page
        Then the user is at the about us page
        
#############################################################################		
#                       ABOUT US PAGE ACTIONS                               #
#############################################################################

@aggregate @front_end_user @about_us
Feature: About us page actions

Background:
    Given the user is at the about us page
    
    Scenario: Move from the about us page to the challenge index page
        Given the user clicks the button to go to the challenge index page
        Then the user is at the default landing page
        
     Scenario: Message the admins
        Given the user clicks on button to message the site admins
        Then the users default email client opens a new email to compose
        And the site email address for front end user responses is pasted into the to field of the email
# TODO: More data likely needed here for definition

          
