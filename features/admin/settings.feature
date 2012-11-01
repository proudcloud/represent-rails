Feature: Global Settings
  In order to customize the site
  As a Site Admin
  I should be able to edit the global settings of the site

  Background:
    Given I have a user account
    And I am signed in
    And I am on the settings page

  Scenario: Changing the name of the site
    When I change the site name
    And I submit the form
    Then my changes should be saved



