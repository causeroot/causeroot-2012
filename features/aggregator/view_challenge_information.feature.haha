
#############################################################################		
#                         VIEW CHALLENGE INFORMATION                        #
#############################################################################

Feature: View challenge information

Background:
    Given the user is viewing the challenge information

    Scenario: Arrival to view the challenge information
        Then there is a title displayed for the challenge
        And there is an award displayed for the challenge
        And there is a deadline displayed for the challenge
        And there is a post date displayed for the challenge
        And there is a description displayed for the challenge
        And there is a rules section displayed for the challenge
        And there is at least one url displayed for the challenge
        And there is an image displayed that relates to the challenge
        And there is a link to email the challenge information
        And there is a link to post this challenge information to facebook
        And there is a link to post this challenge information to twitter
        And there is a navbar

    Scenario: Emailing the challenge information
        Given the user clicks the link to email the challenge information
        Then the users default email client opens a new email to compose
        And the challenge information text is pasted into the new email draft
# TODO: More data likely needed here for definition

    Scenario: Posting a link to the challenge information to facebook
        Given the user clicks the link to post the challenge information to facebook
        Then the users facebook account is opened 
        And a draft post is created to post the challenge information and URL to their wall
# TODO: More data likely needed here for definition

    Scenario: Posting a link to the challenge information to twitter
        Given the user clicks the link to post this url to twitter
        Then the users twitter program is opened
        And a new tweet is drafted
        And the challenge title and URL is posted in the drafted tweet
# TODO: More data likely needed here for definition        
