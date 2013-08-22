Feature: QMS 30
  As a site owner I want a content type of assured member 
  so that information about assured members can be displayed on the site

  @api
  Scenario: Profile "Assured Member" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/profiles"
    Then I should see "Assured Member"

  @api
  Scenario: Profile "Assured Member" has fields
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/profiles/manage/assured_member/fields"
    Then I should see "Name"
    And I should see "Address"
    And I should see "Phone"
    And I should see "Member Type"
    And I should see "Member Category"
    And I should see "Membership Number"
    And I should see "Primary CPH"
    And I should see "CPH Number"
    And I should see "Slapmark"
    And I should see "Approved"


