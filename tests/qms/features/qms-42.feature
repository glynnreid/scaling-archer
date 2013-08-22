Feature: QMS 42
  As a site owner I want a content type healthy eating so that healthy eating content can be displayed on my site

	@api
  Scenario: Content type "Healthy eating" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types"
    Then I should see "Healthy eating (Machine name: healthy_eating)"	





