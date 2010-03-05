require 'spec_helper'

describe PostsController do
  integrate_views
  
  before do
    @post = Post.make
    3.times { @post.comments.make }
  end
  
  it "render index" do
    get :index
    response.should be_success
  end
  
  it "render show" do
    get :show, :id => @post.to_param
    response.should be_success
  end
  
  describe "(not signed in)" do
    it "redirect for :new" do
      get :new
      response.should be_redirect
    end
  end
  
  describe "(signed in)" do
    before do
      @user = User.make
      sign_in :user, @user
    end
    it "renders :new" do
      get :new
      response.should be_success
    end
    
    it "create post" do
      proc {
        post :create, :post => {:title => "Post Title", :body => "Post Body"}
      }.should change(Post, :count).by(1)
      response.should be_redirect
    end
    
    it "renders :edit" do
      get :edit, :id => Post.first.to_param
    end
    
    it "updates post" do
      put :update, :id => @post.to_param, :post => {:title => "New Title", :body => "New Body"}
      response.should be_redirect
    end
    
    it "deletes post" do
      
    end
  end

end
