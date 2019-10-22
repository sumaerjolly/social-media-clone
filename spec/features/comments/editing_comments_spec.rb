# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Editing a comment' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'posting@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)
    @post = Post.create(title: 'test title', body: 'testing title with rspec', user: @user)
    @comment = Comment.create(body: 'testing delete comment', user: @user, post: @post)
  end

  scenario 'A user can update a comment' do
    visit '/'
    within '#minute' do
      click_link 'Edit'
    end
    fill_in 'comment[body]', with: 'Creating a Comment'
    click_button 'Update Comment'
    expect(page).to have_content('Your comment was susccessfully updated')
    expect(page.current_path).to eq(authenticated_root_path)
  end

  scenario 'A user fails to update a comment' do
    visit '/'
    within '#minute' do
      click_link 'Edit'
    end
    fill_in 'comment[body]', with: ''
    click_button 'Update Comment'
    expect(page).to have_content("Body can't be blank")
    expect(page.current_path).to eq(post_comment_path(@post, @comment))
  end
end
