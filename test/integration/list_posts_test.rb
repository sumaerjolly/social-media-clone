# frozen_string_literal: true

require 'test_helper'

class ListPostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @post = Post.create(title: 'test-post', body: 'this is the body of the test title', user: @user)
    @post1 = Post.create(title: 'test-post-2', body: 'this is the body of the test title 2', user: @user)
  end

  test 'should show posts listing' do
    sign_in(@user)
    get posts_path
    assert_template 'posts/index'
    assert_match 'test-post', response.body
    assert_match 'test-post-2', response.body
  end
end
