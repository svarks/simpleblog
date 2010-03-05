# module RspecIntegrationHelpers
class Spec::Rails::Example::IntegrationExampleGroup
  
  def login_user(user=nil)
    unless user
      @user = User.make
    end
    
    visit new_user_session_url
    fill_in "username or email", :with => @user.username
    fill_in "password", :with => 'secret'
    click_button "sign in"
  end
  
end
