Feature: Basic 1 - Site exists
  In order to see a working site
  As an anonymous user on the homepage
  I should see the site under maintenance message

  Scenario: Check for maintenance message
    Given I am an anonymous user
    And I am on the homepage
    Then I should see "Site under maintenance"


