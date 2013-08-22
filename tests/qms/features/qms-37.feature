Feature: QMS 38
  As a site owner I want to have a taxonomy called assurance type so that I can categorise the assurance programmes content type

	@api
  Scenario: Vocab "assurance type" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Assurance Types"

  @api
  Scenario: Vocab "Member type" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/assurance_types/"
    Then I should see "Cattle and Sheep"
    And I should see "Feeds Standards"
    And I should see "Haulage Standards"
		And I should see "Auction Mart Standards"
		And I should see "Processor Standards"
		And I should see "Pig Standards"
		





