# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Deleting a comment' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)

    @post = Post.create(title: 'test title', body: 'testing title with rspec', user: @user)
    @comment = Comment.create(body: 'testing delete comment', user: @user, post: @post)
  end

  scenario 'A user deletes a comment' do
    visit '/'
    within '.delete-link' do
      click_link 'Delete'
    end

    expect(page).to have_content('Comment was successfully deleted')
    expect(current_path).to eq(authenticated_root_path)
  end
end
