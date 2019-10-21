# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Editing a post' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'example@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)
    @post = Post.create(title: 'Test', body: 'Body Test', user: @user)
  end

  scenario 'A user can update a post' do
    visit '/'

    click_link 'Edit'

    fill_in 'post[title]', with: 'Creating a Post'
    fill_in 'post[body]', with: 'Lorem Ipsum'
    click_button 'Update Post'

    expect(page).to have_content('Your post was susccessfully updated')
    expect(page.current_path).to eq(authenticated_root_path)
  end

  scenario 'A user fails to update a post' do
    visit '/'

    click_link 'Edit'

    fill_in 'post[title]', with: ''
    fill_in 'post[body]', with: 'Lorem Ipsum'
    click_button 'Update Post'

    expect(page).to have_content("Title can't be blank")
    expect(page.current_path).to eq(post_path(@post))
  end
end
