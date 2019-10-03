# frozen_string_literal: true

require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'jolly')
    @event = Event.create(description: 'Testing', date: '2019-09-26 00:00:00', creator: @user)
    @event1 = Event.create(description: 'Description', date: '2019-09-26 00:00:00', creator: @user)
  end

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
