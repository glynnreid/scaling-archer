Feature: QMS 50
  As a site owner I want a taxonomy called advice type so that the advice content type can be categorised

	@api
  Scenario: Vocab "Advice type" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Advice Types"

  @api
  Scenario: Vocab "Advice type" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/advice_types/"
    Then I should see "Added Value Project"
    And I should see "Dressing Specs"
    And I should see "Beef EQ"
		And I should see "Lamb EQ"
		And I should see "Tagging"
		And I should see "BIG"

