Given /^I am an authenticated user$/ do 
  @current_user = User.make
  Given "I am on the login page"
  When "I fill in \"username or email\" with \"#{@current_user.username}\""
  And "I fill in \"password\" with \"secret\""
  And "I press \"sign in\""
end

Then /^I am redirected to "([^\"]*)"$/ do |url|
  assert [301, 302].include?(@integration_session.status), "Expected status to be 301 or 302, got #{@integration_session.status}"
  location = @integration_session.headers["Location"]
  assert_equal url, location
  visit location
end

When /^I go to the (.+) page for my (.+)$/ do |action, model|
  visit polymorphic_path(eval("@#{model}"), :action => action.to_sym)
end



# Given /^I am logged in as (.+)$/ do |user|
#   @current_user = user
#   @session["warden.user.user.key"] = [@user.class, @user.id]
# end
# 
# Then /^I am redirected to login page$/ do
#   Then "I am redirected to \"#{new_user_session_path(:unauthenticated => true)}\""
# end
