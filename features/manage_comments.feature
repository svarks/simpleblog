Feature: Manage comments

  Background:
    Given post exists
  
  Scenario: Add Comment as guest
    Given I created a new comment
    Then I should see "Comment Message" within "#comments"
    
  Scenario: Create, Update, remove comment as authenticated user
    Given I am an authenticated user
    Given I created a new comment
    
    When I follow "edit" within ".comment-actions"
    And I fill in "comment_body" with "Changed Message"
    And I press "comment_submit"
    Then I should see "Changed Message" within "#comments"
    
    When I follow "destroy" within ".comment-actions"
    Then I should see "Successfully destroyed comment"
