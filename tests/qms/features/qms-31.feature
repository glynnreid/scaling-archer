Feature: QMS 31
  As a site owner I want a taxonomy of member category so that I can categorise assured members

  @api
  Scenario: Vocab "Member Category" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Member Category"

  @api
  Scenario: Vocab "Member Category" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/member_category/"
    Then I should see "Feed Company"
    And I should see "Haulier"
    And I should see "Auction Market"
    And I should see "Pig Farm"
    And I should see "Farmer"


