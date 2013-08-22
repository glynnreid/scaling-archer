Feature: QMS 105
  As a site owner I want a taxonomy of glossary of terms associated with the cutting guide so that they can be displayed in the cutting guide section

	@api
  Scenario: Vocab "Glossary" exists
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy"
    Then I should see "Glossary"

  @api
  Scenario: Vocab "Glossary" has terms
    Given I am logged in as a user with the "administrator" role
    And I visit "/admin/structure/taxonomy/glossary"
    Then I should see "Ageing"
    And I should see "Atich-bone"
    And I should see "Backfat"
    And I should see "Bruising"
    And I should see "Chine"
    And I should see "Chop"
    And I should see "Chump"
    And I should see "Cod fat"
    And I should see "Cold shortening"
    And I should see "Connective tissue"
    And I should see "Eye muscle"
    And I should see "Gigot"
    And I should see "Gristle or cartilage"
    And I should see "Intermuscular fat"
    And I should see "Lairage"
    And I should see "Lean"
    And I should see "LMC"
    And I should see "Loin"
    And I should see "Primal jointing"
    And I should see "Probe"
    And I should see "Rack"
    And I should see "Rind"
    And I should see "Saddle"
    And I should see "Scrag"
    And I should see "Seam butchery"
    And I should see "Shank"
    And I should see "Tendon"
		
	

