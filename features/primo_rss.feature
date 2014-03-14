@selenium
Feature: Bobcat homepage tip of the week RSS.
  As a user.
  In order to find subscribe to the tip of the week.
  Going to BobCat should show me an RSS icon next to tip of the week.

  Scenario: Default Precision Operator Search brief results.
    Given I am on the Bobcat homepage
    Then I should see the RSS icon next to tip of the week