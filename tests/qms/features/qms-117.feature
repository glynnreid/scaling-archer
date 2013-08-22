Feature: QMS 117
  As a site owner I want to have a taxonomy called event type so that I can categorise the event content type

	@api
  Scenario: Vocab "event type" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Event Types"

  @api
  Scenario: Vocab "Event type" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/event_types"
    Then I should see "Conference"
    And I should see "Workshop"
    And I should see "Meeting"
		And I should see "Monitor farm"



