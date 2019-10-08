# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Creating Posts' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)
  end

  scenario 'A user creates a new post' do
    visit '/'

    fill_in 'post[title]', with: 'Creating a Post'
    fill_in 'post[body]', with: 'Lorem Ipsum'

    click_button 'Create Post'

    expect(Post.last.user).to eq(@user)
    expect(page).to have_content('Your post was susccessfully created')
    expect(page).to have_content('Creating a Post')
    expect(page).to have_content('Lorem Ipsum')
  end

  scenario 'A user creates an invalid new post' do
    visit '/'

    fill_in 'post[title]', with: ' '
    fill_in 'post[body]', with: ' '

    click_button 'Create Post'

    expect(page).to have_content('Your post could not be created')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
