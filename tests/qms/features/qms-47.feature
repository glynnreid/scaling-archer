Feature: QMS 47
  As a site owner I want a content type called campaign so that campaign information can be displayed on my site

	@api
  Scenario: Content type "Campaign" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types"
    Then I should see "Campaign (Machine name: campaign)"		





