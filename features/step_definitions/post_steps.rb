Given /^I created a new post$/ do
  When "I go to the new post page"
  And "I fill in \"title\" with \"Post Title\""
  And "I fill in \"body\" with \"Post Body\""
  Then "I press \"create\""
end

