# frozen_string_literal: true

require 'test_helper'

class UpdateUsersTest < ActionDispatch::IntegrationTest
  
   def setup
     @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
   end

  test "should update user details" do
    sign_in(@user)
    get  edit_user_registration_path(@user)
    assert_template 'devise/registrations/edit'
    patch user_registration_url, params: {user: {last_name: "updated"}}
    @user.reload
    assert_equal "updated", @user.last_name
  end


end