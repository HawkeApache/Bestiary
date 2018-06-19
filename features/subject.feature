Feature: Watching Subjects
  Signed in users want to see Subjects

  Scenario: Signed in User can see list of subjects
    Given I exist as a user
    And I sign in with valid credentials
    And Subjects are in database
    When I visit subjects page
    Then I can see list of all subjects

  Scenario: Admin can add new Subject
    Given I exist as an Admin
    And I sign in with valid credentials as Admin
    When I visit subjects page
    Then I can see button to adding subjects