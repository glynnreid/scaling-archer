Feature: QMS 38
  As a site owner I want to have a content type news so that news can be displayed on the site

	@api
  Scenario: Content type "News" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types"
    Then I should see "News (Machine name: news)"	





