require 'test_helper'
include SessionHelper

class SessionControllerTest < ActionController::TestCase
  def setup
    @user = users(:one) 
  end

  test 'should get new' do
    get :new
    assert_response :success
    assert_template :new
  end

  test 'should create session with valid credentials' do
    post :create, params: { email: @user.email, password: 'password' }
    assert_redirected_to dashboard_path
    assert_equal 'Logged in successfully!', flash[:notice]
  end

  test 'should handle wrong password' do
    post :create, params: { email: @user.email, password: 'wrong_password' }
    assert_redirected_to login_path
    assert_equal 'Wrong password for the provided email!', flash[:alert]
  end

  test 'should handle unknown email' do
    post :create, params: { email: 'unknown@example.com', password: 'password' }
    assert_redirected_to login_path
    assert_equal 'Email not found!', flash[:alert]
  end

  test 'should destroy session on logout' do
    sign_in(@user) 
    delete :destroy
    assert_redirected_to login_path
    assert_equal 'Logged out successfully!', flash[:notice]
  end
end
