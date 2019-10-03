require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::ControllerHelpers 

    def setup
        @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
    end

    test 'should get users index' do 
        sign_in @user
        get users_path
        assert_response :success
    end
end
