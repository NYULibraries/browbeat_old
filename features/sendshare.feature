@selenium
Feature: Bobcat search results sendshare feature.
  As a user.
  In order to send or share resources
  Clicking on Send/Share dropdown menu will give me options to share the resource.

  Scenario: Send/Share is properly formatted.
    Given I am on the Bobcat homepage
    When I search for "virtual inequality"
	And I click on send/share
	Then I should see an option for "EndNote"
	Then I should see an option for "RefWorks"
	Then I should see an option for "EasyBIB"
	Then I should see an option for "RIS"
	Then I should see an option for "BibTeX"
