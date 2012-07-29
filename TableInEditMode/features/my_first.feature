Feature: Running a test
  As an iOS developer
  I want to have a sample feature file
  So I can begin testing quickly

  Scenario: Example steps
    Given I am on the Welcome Screen
    Then I swipe left
    And I wait until I don't see "Please swipe left"
    And take picture

  Scenario: demonstrate how to find the device orientation
    Then I should be able to find the device orientation


