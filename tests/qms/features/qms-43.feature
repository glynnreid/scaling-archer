Feature: QMS 43
  As a site owner I want a taxonomy called healthy eating so that I can categorise the healthy eating content type

	@api
  Scenario: Vocab "healthy eating" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "healthy eating"

  @api
  Scenario: Vocab "healthy eating" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/healthy_eating/"
    Then I should see "why red meat"
    And I should see "keep it safe"
    And I should see "resources"
		And I should see "food farming and welfare"
		And I should see "school extras"

	