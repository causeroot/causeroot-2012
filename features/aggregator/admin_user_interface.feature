
# This is the first draft of the Admin interface
# It probably needs more tests and work ... please review & comment!!!

#############################################################################		
#                              NEW FEATURE                                  #
#############################################################################

@aggregate @admin @sign_in
Feature: Admin sign in page definition

    Scenario:
        Given the admin is at the sign in page
        Then there is an empty text box for password 
        And there is an empty text box for username
        And there is a login button
        And there is a button to request a username
        And there is a button to request a password        

#############################################################################		
#                              NEW FEATURE                                  #
#############################################################################

@aggregate @admin @sign_in
Feature: Admin sign in page actions

Background: 
    Given the admin is at the sign in page
    And the admin attempts to sign in
 
    Scenario: Sign in successful        
        When the admin enters username in the username text box
        And the admin enters password in the password text box
        And the admin clicks the login button
        And the enters username exists in the database
        And the enters password is correctly associated with the username in the database
        Then the admin will be logged in
        And the admin will be brought to the challenge index page
    
    Scenario: Sign in but invalid username
        When the admin enters username in the username text box
        And the admin enters password in the password text box
        And the admin clicks the login button
        And the enters username does not exist in the database
        And the enters a password
        Then a display message in a new window indicates an invalid username was used
        And there is an empty text box for password 
        And there is an empty text box for username
           
     Scenario: Sign in but invalid password
        When the admin enters username in the username text box
        And the admin enters password in the password text box
        And the admin clicks the login button
        And the enters username does not exist in the database
        And the enters a password
        And a display message in a new window indicates an invalid password was used
        Then there is an empty text box for password 
        And there is an empty text box for username        
    
    Scenario: Successful username request
        Given the admin clicks the retrieve username button
        And there is an empty text box for the admins email address
        And there is a button to send the username to the admins email address
        Then the admin enters his username that in the email address textbox
        And the admin enters his email address that in the email address textbox
        And the admin clicks the button to send username it his email address
        And the entered email address is recognized in the database
        Then the username associated with the admins email address is sent to the admin
        And there is the empty text box for the admins email address is no longer there
        And there is a button to send the username to the admins email address is no longer there
        And a display in a new window indicates than at email was sent to the admins email address

    Scenario: Unsuccessful username request
        Given the admin clicks the retrieve username button
        And there is an empty text box for the admins email address
        And there is a button to send the username to the admins email address
        Then the admin enters his username that in the email address textbox
        And the admin enters his email address that in the email address textbox
        And the admin clicks the button to send username it his email address
        And the entered email address is not recognized in the database
        Then a display in a new window indicates than at email address was not identified
            
    Scenario: Successful password reset
        Given the admin clicks the reset his password button
        And there is an empty text box for the admins email address
        And there is a button to send the username to the admins email address
        Then the admin enters his username that in the email address textbox
        And the admin enters his email address that in the email address textbox
        And the admin clicks the button to send username it his email address
        And the entered email address is recognized in the database
        Then the username associated with the admins email address is sent to the admin
        And there is the empty text box for the admins email address is no longer there
        And there is a button to send the username to the admins email address is no longer there
        And a display in a new window indicates than at email was sent to the admins email address

    Scenario: Unsuccessful username request
        Given the admin clicks the retrieve username button
        And there is an empty text box for the admins email address
        And there is a button to send the username to the admins email address
        Then the admin enters his username that in the email address textbox
        And the admin enters his email address that in the email address textbox
        And the admin clicks the button to send username it his email address
        And the entered email address is not recognized in the database
        Then a display in a new window indicates than at email address was not identified


#############################################################################		
#                              NEW FEATURE                                  #
#############################################################################

@aggregate @admin @sign_in
Feature: Password Reset

Background: 
    Given the admin is at the sign in page
    And the admin attempts to reset his password
    And the admin is at a display that prompts him for his email

    Scenario: Successful password reset
        Given the admin enters an email address that is in the database
        And the admin clicks the reset password button
        Then display text indicates that the password has been reset
        And display text indicates that a password reset email was sent
        And the admin has the ability to log in
        
    Scenario: Unsuccessful password reset
        Given the admin enters an email address that is not in the database
        And the admin clicks the reset password button
        Then display text indicates that the username is invalid
        And the admin has the ability to log in   
        And the admin has the ability to reset his password

#############################################################################	
#                              NEW FEATURE                                  #
#############################################################################

@aggregate @admin @challenge_index_page
Feature: Admin at challenge index page definition

The admin has all all the rights of a user; however, a user does not have admin rights

Background:
    Given the admin has successfully logged in
    And the admin is at the challenge index page
    
    Scenario: 
        Given there that there is a link to the challenge submission page 
        And there is a display that indicates the admin is successfully logged in
        And it indicates the username if the admin that is signed
        And there is a logout link

#############################################################################	
#                              NEW FEATURE                                  #
#############################################################################

@aggregate @admin @challenge_index_page
Feature: Admin at challenge index page actions

The admin has all all the rights of a user; however, a user does not have admin rights

Background:
    Given the admin has successfully logged in
    And the admin is at the challenge index page
    
    Scenario: 
        Given the admin clicks the link to the challenge submission page 
        Then the admin is at the challenge submission page
    
    Scenario:
        Given the admin clicks the link to logout 
        Then the admin becomes a user      

#############################################################################		
#                              NEW FEATURE                                  #
#############################################################################

@aggregate @admin @challenge_submission_page
Feature: Challenge submission page definition
   
    Scenario:
        Given the admin is at the challenge submission page
        Then there is a text box for the title of a challenge object
        And there is a save button for the titel text box for the of a challenge object
        And there is a text box for the URL of a challenge object
        And there is a save button for the URL text box for the of a challenge object
        And there is a text box for the description of a challenge object
        And there is a save button for the description text box for the of a challenge object
        And there is a text box for the rules of a challenge object
        And there is a save button for the rules text box for the of a challenge object
        And there is a text box for the deadline of a challenge object
        And there is a save button for the deadline text box for the of a challenge object
        And there is a text box for the postdate of a challenge object
        And there is a save button for the postdate text box for the of a challenge object
        And there is a text box for the award of a challenge object
        And there is a save button for the award text box for the of a challenge object
        And there is a text box for the checkup xpaths of a challenge object
        And there is a save button for the checkup xpaths text box for the of a challenge object
        And there is a text box for the image xpath of a challenge object
        And there is a save button for the image xpaths text box for the of a challenge object
        And there are all parts of an individual challenge page
        And there is a link to go back to the challenge index page
        And there is a display that indicates the admin is successfully logged in
        And it indicates the username if the admin that is signed
        And there is a logout link

# TEST NOTE: Make a step of the above

#############################################################################		
#                              NEW FEATURE                                  #
#############################################################################
        
@aggregate @admin @challenge_submission_page
Feature: First challenge submission page landing

Background:
    Given the admin is at the challenge submission page

    Scenario:
        Given the admin is arriving to the site for the first time
        Then all the fields of the individual challenge page are empty strings
        
#############################################################################		
#                              NEW FEATURE                                  #
#############################################################################

@aggregate @admin @challenge_submission_page
Feature: challenge submission page actions
   
    Scenario: Adding text to the text box for the title of a challenge object
        Given that the admin writes a string into the text box for the title of the individual challenge
        And the admin clicks the submit button add the title to the individual challenge
        Then the title appears in the title section of the individual challenge page

    Scenario: Adding text to the text box for the URL of a challenge object
        Given that the admin writes a string into the text box for the URL of the individual challenge
        And the admin clicks the submit button add the URL to the individual challenge
        Then the title appears in the URL section of the individual challenge page

    Scenario: Adding text to the text box for the description of a challenge object
        Given that the admin writes a string into the text box for the description of the individual challenge
        And the admin clicks the submit button add the description to the individual challenge
        Then the title appears in the description section of the individual challenge page

    Scenario: Adding text to the text box for the rules of a challenge object
        Given that the admin writes a string into the text box for the rules of the individual challenge
        And the admin clicks the submit button add the rules to the individual challenge
        Then the title appears in the rules section of the individual challenge page

    Scenario: Adding text to the text box for the postdate of a challenge object
        Given that the admin writes a string into the text box for the postdate of the individual challenge
        And the admin clicks the submit button add the postdate to the individual challenge
        Then the title appears in the postdate section of the individual challenge page

    Scenario: Adding text to the text box for the award of a challenge object
        Given that the admin writes a string into the text box for the award of the individual challenge
        And the admin clicks the submit button add the award to the individual challenge
        Then the title appears in the award section of the individual challenge page

    Scenario: Adding text to the text box for the checkup xpaths of a challenge object
        Given that the admin writes a string into the text box for the checkup xpaths of the individual challenge
        And the admin clicks the submit button add the checkup xpaths to the individual challenge
        Then the title appears in the checkup xpaths section of the individual challenge page

    Scenario: Adding text to the text box for the image xpaths of a challenge object
        Given that the admin writes a string into the text box for the image xpaths of the individual challenge
        And the admin clicks the submit button add the image xpaths to the individual challenge
        Then the title appears in the image xpaths section of the individual challenge page

    Scenario: Save the new individual challenge to the database
        Given that the admin clicks the save button for the individual challenge
        Then the individual challenge is then added to the challenge index database
        And the text box for the title of the individual challenge is blank
        And the text box for the URL of the individual challenge is blank
        And the text box for the description of the individual challenge is blank
        And the text box for the rules of the individual challenge is blank
        And the text box for the deadline of the individual challenge is blank
        And the text box for the postdate of the individual challenge is blank
        And the text box for the award of the individual challenge is blank
        And the text box for the checkup xpaths of the individual challenge is blank
        And the text box for the image xpath of the individual challenge is blank
        
    Scenario: Go back to the challenge index page
        Given that the admin clicks the link to go back to the challenge index page
        Then the admin is a the challenge index page

    Scenario:
        Given the admin clicks the link to logout
        Then the admin is at the challenge submission page 
        Then the admin becomes a user  
        
        
        