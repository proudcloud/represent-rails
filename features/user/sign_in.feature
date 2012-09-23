Feature: Sign in
  In order to access the admin page
  As a User
  I should be able to sign in

  Scenario: Existing User
    Given I have a user account
    And I am not signed in
    When I sign in with valid credentials
    Then I should see "Signed in successfully."
    And I should be signed in
    And I should be redirected to the admin page

  Scenario: Invalid User
    Given I do not have a user account
    And I am not signed in
    When I sign in with valid credentials
    Then I should be signed out

  Scenario: Wrong Email or Password
    Given I have a user account
    And I am not signed in
    When I sign in with invalid credentials
    Then I should be signed out
