
#############################################################################		
#                             ABOUT US PAGE                                 #
#############################################################################

@aggregate @front_end_user @about_us_page

Feature: About us page

	Scenario: About us page arrival
	    Given the user arrives at the about us page
        Then there is a navbar
        And there is a button to message the site admins
        And there is the project misson statement containing:
        """
        We aim to foster an informed global community that is focused on incrementally building a better world.
        """
        And there is at least one graphic
        
     Scenario: Message the admins
        Given the user clicks on button to message the site admins
        Then the users default email client opens a new email to compose
        And the site email address for front end user responses is pasted into the to field of the email.
        
# TODO: More data likely needed here for definition

          
