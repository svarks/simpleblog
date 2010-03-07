Feature: Manage posts
  
  Scenario: Create, update, destroy post
    Given I am an authenticated user
    And I created a new post
    And I follow "edit"
    And I fill in "title" with "Changed Post Title"
    And I press "update"
    Then I should see "Changed Post Title"
    When I follow "destroy"
    Then I should see "Successfully destroyed post"
