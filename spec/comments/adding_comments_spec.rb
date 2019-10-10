# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Adding Comments to Posts' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)

    @post = Post.create(title: 'test title', body: 'testing title with rspec', user: @user)
  end

  scenario 'A user adds a comment to a post' do
    visit '/'

    fill_in 'comment[body]', with: 'Adding a comment'

    click_button 'Add Comment'

    expect(Comment.last.user).to eq(@user)
    expect(page).to have_content('Comment has been created')
    expect(page).to have_content('Adding a comment')
  end

  scenario 'A user creates an invalid new comment' do
    visit '/'
    fill_in 'comment[body]', with: ''

    click_button 'Add Comment'

    expect(page).to have_content("Body can't be blank")
  end
end
