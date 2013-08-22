Feature: Basic 2 - User can login
  In order to use the site
  I should be able to login

  @api
  Scenario: Check user can login
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    Then I should see "Log out"

