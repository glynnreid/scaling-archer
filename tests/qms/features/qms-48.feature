Feature: QMS 48
  As a site owner I want a taxonomy called campaign type so that the campaign content type can be categorised

	@api
  Scenario: Vocab "campaign type" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Campaign types"

  @api
  Scenario: Vocab "campaign type" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/campaign_types/"
    Then I should see "Scotch Beef"
    And I should see "Scotch Lamb"
    And I should see "Specially Selected Pork"
		And I should see "Behind the Label"
		And I should see "Butchers"
		And I should see "Restaurants"
		And I should see "Exports"

