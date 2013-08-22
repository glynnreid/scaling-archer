Feature: QMS 32
  As a site owner I want a taxonomy of member type so that I can categorise assured members


  @api
  Scenario: Vocab "Member type" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Member Type"

  @api
  Scenario: Vocab "Member type" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/member_type/"
    Then I should see "Beef"
    And I should see "Lamb"
    And I should see "Pig"


