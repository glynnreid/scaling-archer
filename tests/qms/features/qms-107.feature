Feature: QMS 107
  As a site owner I want a taxonomy called Cut Area/Animal part so that the cutting guide can be categorised

	@api
  Scenario: Vocab "Cutting Guide" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Cutting Guide"

  @api
  Scenario: Vocab "Cutting Guide" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/cutting_guide"
    Then I should see "Beef Forequarter"
    And I should see "Forerib"
    And I should see "Brisket"
    And I should see "Shin,neck and clod"
    And I should see "Beef Hindquarter"
    And I should see "Thin Flank"
    And I should see "Fillet sirloin"
    And I should see "Top Bit"
    And I should see "Lamb"
    And I should see "Leg and Chump"
    And I should see "Saddle"
    And I should see "Shoulder"
    And I should see "Pork (Major primals)"
    And I should see "Leg and Chump"
    And I should see "Middle"
    And I should see "Fore-end"
    And I should see "Pork (Individual primals)"
    And I should see "Leg and Chump"
    And I should see "Middle"
    And I should see "Fore-end"

