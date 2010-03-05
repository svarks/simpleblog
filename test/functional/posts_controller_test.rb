require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  test "index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end
  
  test "show" do
    assert true
  end
  
end