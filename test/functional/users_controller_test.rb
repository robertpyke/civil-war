require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:robert)
  end

  test "should get index" do
    sign_in @user

    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should show user" do
    sign_in @user

    get :show, id: @user
    assert_response :success
  end

end
