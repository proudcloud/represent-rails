Feature: Sign out
  In order to protect my account
  As a User
  I should be able to sign out

  Scenario: User signs out
    Given I am signed in
    When I sign out
    Then I should be signed out
