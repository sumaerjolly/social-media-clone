# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Unliking a post' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)
    @post = Post.create(title: 'Test', body: 'Body Test', user: @user)
    @like = Like.create(post: @post, user: @user)
  end

  scenario 'A user can unlike a post' do
    visit '/'

    click_link 'Unlike'

    expect(page).to have_content('You have successfully unliked a post')
  end
end
