Feature: QMS 40
  As a site owner I want a content type Event so that I can display events on my site

	@api
  Scenario: Content type "Event" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types"
    Then I should see "Event (Machine name: event)"		





