require 'spec_helper'

describe "Comments" do
  before do
    @post = Post.make
  end
  
  describe "(not logged in)" do
    before do
      visit post_url(@post)
    end
    
    it "create new comment" do
      fill_in :comment_author_name, :with => "Commenter"
      fill_in :comment_body, :with => "Message"
      click_button :comment_submit
      # save_and_open_page
    end
  end
  
  describe "(logged in)" do
    before do
      login_user
      visit post_url(@post)
    end
    
    it "create, update and destroy comment" do
      fill_in :comment_body, :with => "Message"
      click_button :comment_submit
      @comment = Comment.first
      visit edit_comment_url(@comment)
      fill_in :comment_body, :with => "New Message"
      click_button :comment_submit
      
      visit comment_url(@comment), :delete
    end
  end
  
end