require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
