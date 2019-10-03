# frozen_string_literal: true

require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest
  test 'get new user form and create user' do
    get new_user_registration_path
    assert_template 'devise/registrations/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 'male', password: 'password' } }
    end
  end

  test 'invalid user submission results in failure' do
    get new_user_registration_path
    assert_template 'devise/registrations/new'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name: ' ', last_name: ' ', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 'male', password: 'password' } }
    end
  end
end
