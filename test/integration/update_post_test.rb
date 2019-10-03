# frozen_string_literal: true

require 'test_helper'

class UpdatePostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @post = Post.create(title: 'test-post', body: 'this is the body of the test title', user: @user)
  end

  test 'should update post' do
    sign_in(@user)
    get edit_post_path(@post)
    assert_template 'posts/edit'
    patch post_url(@post), params: { post: { title: 'updated' } }
    follow_redirect!
    assert_template 'posts/index'
    @post.reload
    assert_equal 'updated', @post.title
  end
end
