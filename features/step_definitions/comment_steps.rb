Given /^I created a new comment$/ do
  When "I go to the page for that post"
  And "I fill in \"comment_author_name\" with \"Commenter\"" unless @current_user
  And "I fill in \"comment_body\" with \"Comment Message\""
  And "I press \"comment_submit\""
end
