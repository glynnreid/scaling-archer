Feature: QMS 36
  As a site owner I want to have a content type for assurance programmes 
  so that information on assurance programmes can be displayed on the site

  @api
  Scenario: Content type "Assurance Programme" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types"
    Then I should see "Assurance Programme"

  @api
  Scenario: Content type "Assurance Programme" has fields
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/types/manage/assurance-programme/fields"
    Then I should see "Title"
    And I should see "Body"
    And I should see "Please Note"
    And I should see "Assurance Type"
    And I should see "Attached Files"
    And I should see "Join Files"





