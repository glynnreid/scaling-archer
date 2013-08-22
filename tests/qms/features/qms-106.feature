Feature: QMS 106
  As a site owner I want a content type called cutting guide so that it can be displayed to users of the site

	@api
  Scenario: Content type "Cutting Guide" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types"
    Then I should see "Cutting Guide (Machine name: cutting_guide)"		





