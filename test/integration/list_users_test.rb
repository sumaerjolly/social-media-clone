# frozen_string_literal: true

require 'test_helper'

class ListUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @user1 = User.create(first_name: 'Sumaer', last_name: 'Doe', email: 'sumaerexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
  end

  test 'should show users listing' do
    sign_in(@user)
    get users_path
    assert_template 'users/index'
    assert_match 'Raja Doe', response.body
    assert_match 'Sumaer Doe', response.body
  end
end
