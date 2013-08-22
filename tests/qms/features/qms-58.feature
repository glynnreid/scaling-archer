Feature: As the site admin I want to manage a document library so that I can attach documents to any content

@api
Scenario: Administrator can access Media Library
  Given I am logged in as a user with the "administrator" role
  And I visit "/admin/content/file"

@api
Scenario: Authorised users can not access Media Library
  Given I am logged in as a user with the "authenticated user" role
  And I go to "/admin/content/file"
  Then I should get a "403" HTTP response

@api
Scenario: Anonymous users can not access Media Library
  Given I am an anonymous user
  And I go to "/admin/content/file"
  Then I should get a "403" HTTP response
