# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                     date_of_birth: '2001-11-5', gender: 1, password: 'password')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'first name should be present' do
    @user.first_name = ' '
    assert_not @user.valid?
  end

  test 'last name should be present' do
    @user.last_name = ' '
    assert_not @user.valid?
  end

  test 'gender should be present' do
    @user.gender = ' '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'date of birth should be present' do
    @user.date_of_birth = ' '
    assert_not @user.valid?
  end

  test 'password should be present' do
    @user.password = ' '
    assert_not @user.valid?
  end

  test 'email should be unique' do
    @user.save
    user2 = User.new(first_name:
     'Sam', last_name: 'Doe', email: 'testingexample@example.com',
                     date_of_birth: '2001-11-5', gender: 1, password: 'password')
    assert_not user2.valid?
  end
end
