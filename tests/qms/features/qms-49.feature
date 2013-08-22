Feature: QMS 49
  As a site owner I want a content type called advice so that advice information can be displayed on my site

	@api
  Scenario: Content type "advice" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types"
    Then I should see "Advice (Machine name: advice)"			





