require 'spec_helper'

describe "Posts" do
  
  describe "(not logged in)" do
  end
  
  describe "(logged in)" do
    before do
      login_user
    end
  
    it "create, update and destroy post" do
      visit new_post_url
      fill_in :title, :with => "Post title"
      fill_in :body, :with => "Post body"
      click_button :create
      
      click_link :edit
      fill_in :title, :with => "New Title"
      fill_in :body, :with => "New Body"
      click_button :update
      
      click_link :destroy
      
      # save_and_open_page
    end
  end

end
