require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @post = Post.create(title: 'test-post', body: 'this is the body of the test title', user: @user)
  end

  test 'should get posts index' do 
    sign_in(@user)
    get posts_path
    assert_response :success
  end

  test 'should get edit' do 
    sign_in(@user)
    get edit_post_path(@post)
    assert_response :success
  end

  test 'should redirect for non signed in user' do 
    get posts_path
    assert_redirected_to new_user_session_path
  end

  test 'should not let post be created user not logged in' do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: 'Testing', body: 'Testing body', user: @user } }
    end
    assert_redirected_to new_user_session_path
  end

end
