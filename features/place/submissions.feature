#@javascript
Feature: Submissions
  In order to put my company on the map
  As a User
  I should be able to submit my company

  Background:
    Given I am on the home page

  Scenario: Place Submission form
    When I click on the link "Add Something!"
    Then I should see the Place Submission form

    When I fill out the Place Submission form
    And I submit the form
    Then my application should be submitted for approval
