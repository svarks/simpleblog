require 'spec_helper'

describe TagsController do
  integrate_views
  
  before do
    3.times do
      post = Post.make
      3.times { post.comments.make }
    end
  end
  
  it "should render show" do
    get :show, :id => Tag.first.to_param
    response.should be_success
  end
  
end