# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @post = Post.new(title: 'Test title', body: 'body', user: @user)
  end

  test 'post should be valid' do
    assert @post.valid?
  end

  test 'title should be present' do
    @post.title = ' '
    assert_not @post.valid?
  end

  test 'body should be present' do
    @post.body = ' '
    assert_not @post.valid?
  end
end
