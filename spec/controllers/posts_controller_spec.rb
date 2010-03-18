require 'spec_helper'

describe PostsController do
  # integrate_views

  before do
    @post = Post.make
  end

  describe "index action" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end
  
  describe "show action" do
    it "should be successful" do
      get :show, :id => @post.to_param
      response.should be_success
    end
  end
  
  describe "create action" do
    describe "if user logged in" do
      before do
        sign_in @post.user
      end
      it "should be successful" do
        post :create, :post => {:title => "Post Title", :body => "Post body"}
        assigns[:post].should_not be_new_record
        response.should redirect_to(post_url(assigns[:post]))
      end
    end
    describe "if user guest" do
      it "should be forbidden" do
        proc {
          post :create, :post => {:title => "Post Title", :body => "Post body"}
        }.should_not change(Post, :count)
        response.should redirect_to(new_user_session_url(:unauthenticated => true))
      end
    end
  end
  
  describe "update action" do
    describe "if user logged in" do
      before do
        sign_in @post.user
      end
      describe "as post owner" do
        it "should be successful" do
          params = {:title => "New Post Title", :body => "New Post body"}
          put :update, :id => @post.to_param, :post => params
          assigns[:post].title.should == params[:title]
          assigns[:post].body.should == params[:body]
          assigns[:post].errors.should be_empty
          response.should redirect_to(post_url(assigns[:post]))
        end
      end
      describe "as not post owner" do
        before do
          sign_in User.make
        end
        it "should be forbidden" do
          params = {:title => "New Post Title", :body => "New Post body"}
          put :update, :id => @post.to_param, :post => params
          assigns[:post].title.should_not == params[:title]
          assigns[:post].body.should_not == params[:body]
          response.should redirect_to(post_url(assigns[:post]))
        end
      end
    end
    describe "if user guest" do
      it "should be forbidden" do
        params = {:title => "New Post Title", :body => "New Post body"}
        put :update, :id => @post.to_param, :post => params
        response.should redirect_to(new_user_session_url(:unauthenticated => true))
      end
    end
  end
  
  describe "destroy action" do
    describe "if user logged in" do
      before do
        sign_in @post.user
      end
      describe "as post owner" do
        it "should be successful" do
          proc {
            delete :destroy, :id => @post.to_param
          }.should change(Post, :count).by(-1)
          response.should redirect_to(root_url)
        end
      end
      describe "as not post owner" do
        before do
          sign_in User.make
        end
        it "should be forbidden" do
          proc {
            delete :destroy, :id => @post.to_param
          }.should_not change(Post, :count)
          response.should redirect_to(post_url(assigns[:post]))
        end
      end
    end
    describe "if user guest" do
      it "should be forbidden" do
        proc {
          delete :destroy, :id => @post.to_param
        }.should_not change(Post, :count)
        response.should redirect_to(new_user_session_url(:unauthenticated => true))
      end
    end
  end

end
