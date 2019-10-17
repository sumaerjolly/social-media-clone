# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Adding Friends' do
  before do
    @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'janedoe@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user1)
  end

  scenario 'A user sends a friend request' do
    visit '/'
    click_link 'All Users'

    click_button 'Add As Friend'

    expect(page).to have_content('Your friend request was sent')
    expect(page).to have_link('Cancel Request')
  end
end
