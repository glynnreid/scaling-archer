Feature: QMS 1 - Site Search
  As a user of the site I want a site-wide keyword search that searches all site content 
  so that a relevant result set is returned

  @api
  Scenario: Do a successful search
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    And I fill in "search_block_form" with "herd"
    And I press "edit-submit"
    Then I should see "Search results"


  @api
  Scenario: Do an unsuccesful search
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    And I fill in "search_block_form" with "xxxxxxxx"
    And I press "edit-submit"
    Then I should see "Check if your spelling is correct"

