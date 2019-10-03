# frozen_string_literal: true

require 'test_helper'

class CreatePostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @post = Post.create(title: 'test-post', body: 'this is the body of the test title', user: @user)
  end

  test 'get new post form and create post' do
    sign_in(@user)
    get posts_path
    assert_template 'posts/index'
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { title: 'Testing', body: 'Testing body', user: @user } }
      follow_redirect!
    end
    assert_template 'posts/index'
    assert_match 'Testing', response.body
  end

  test 'invalid post submission results in failure' do
    sign_in(@user)
    get posts_path
    assert_template 'posts/index'
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: ' ', body: ' ', user: @user } }
    end
    assert_template 'posts/index'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
