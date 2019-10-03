require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
  end

  test 'should get users index' do 
    sign_in(@user)
    get users_path
    assert_response :success
  end

  test 'should get individual user page' do 
    sign_in(@user)
    get user_path(@user)
    assert_response :success
  end

  test 'should redirect for non signed in user' do 
    get users_path
    assert_redirected_to new_user_session_path
  end

end
