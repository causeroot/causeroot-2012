
#############################################################################		
#                    INDIVIDUAL CHALLENGE PAGE: DEFINITION                   #
#############################################################################

Feature: Individual Challenge page definition

Background:
    Given the user is at an individual challenge page

    Scenario: Individual Challenge page
        Given the user is at an individual challenge page
        Then there is a title displayed for the individual challenge
        And there is an award displayed for the individual challenge
        And there is a deadline displayed for the individual challenge
        And there is a post date displayed for the individual challenge
        And there is a description displayed for the individual challenge
        And there is a rules section displayed for the individual challenge
        And there is at least one url displayed for the individual challenge
        And there is an image displayed that relates to the individual challenge
        And there is a link to email the individual challenge page data
        And there is a link to post this individual challenge page to facebook
        And there is a link to post this individual challenge to a twitter
        And there is a navbar

    Scenario: Emailing the individual challenge data
        Given the user clicks the link to email the individual challenge page data
        Then the users default email client opens a new email to compose
        And the individual challenge page data text is pasted into the new email draft
# TODO: More data likely needed here for definition

    Scenario: Posting a link to this individual challenge page on facebook
        Given the user clicks the link to post this individual challenge page to facebook
        Then the users facebook account is opened 
        And a draft post is created to post the individual challenge data and URL to their wall
# TODO: More data likely needed here for definition

    Scenario: Posting a link to this individual challenge page on twitter
        Given the user clicks the link to post this url to twitter
        Then the users twitter program is opened
        And a new tweet is drafted
        And the individual challenge title and URL is posted in the drafted tweet
# TODO: More data likely needed here for definition        
