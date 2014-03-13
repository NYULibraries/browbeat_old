@selenium
Feature: Bobcat Default Precision Operator Search brief results page.
  As a user.
  In order to find resources by title containing a phrase
  Searching bobcat with Default Precision should give me a relevant top result in a brief format.

  Scenario: Default Precision Operator Search brief results.
    Given I am on the Bobcat homepage
    When I search for "virtual inequality"
    Then I should see that the title of default search page is "BobCat - virtual inequality"
	And I should see common elements
	And I should see facets
	And I should see results
	And I should see 8 result items
	And I should see pagination