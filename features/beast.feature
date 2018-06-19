Feature: Watching Beasts
  Signed in users want to see Beasts in their natural environment

  Scenario: Signed in User can see list of beasts
    Given I exist as a user
    And I sign in with valid credentials
    When I visit beasts page
    Then I can see list of all beasts

  Scenario: Admin can add new Beasts
    Given I exist as an Admin
    And I sign in with valid credentials as Admin
    When I visit beasts page
    Then I can see button to adding beasts

