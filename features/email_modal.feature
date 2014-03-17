@selenium
Feature: Bobcat email link launches modal dialog
  As a user.
  In order to email results to myself or others
  Clicking the "E-mail" option under Send/Share should not direct me away to another page but should launch in a Bootstrap popup

  Scenario: E-mail send option is clicked and displays e-mail form in modal dialog
    Given I am on the Bobcat homepage
    When I search for "virtual inequality"
  	And I click on send/share
  	Then I should see an option for "E-mail"
    Then I click on the option for "E-mail"
    Then I should see a modal dialog
    And The modal dialog should contain the email form
  
  Scenario: E-mail form gets sent when a valid email address is entered
    Given I am on the Bobcat homepage
    When I search for "virtual inequality"
  	And I click on send/share
    Then I click on the option for "E-mail"
    Then I fill in "sendTo" with "email@example.com"
    And I click on the "Send" button
    Then I should see the message "Your message has been sent."
