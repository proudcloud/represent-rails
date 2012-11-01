Feature: Sign out
  In order to protect my account
  As a User
  I should be able to sign out

  Background:
    Given I have a user account
    And I am signed in
    And I am on the admin page

  Scenario: User signs out
    When I sign out
    Then I should be signed out
