Feature: QMS 92
  As a site owner I want CAPTCHA on the registration form so that spam registrations are reduced

	Scenario: Check for CAPTCHA Input
    Given I am an anonymous user
		And I visit "/user/register"
		And I fill in "mollom[captcha]" with "xxxxxx"





