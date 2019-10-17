# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cancelling Friend request' do
  before do
    @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'janedoe@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user1)
    @friendship = Friendship.create(user: @user1, friend: @user2)
  end

  scenario 'A friend request is cancelled' do
    visit '/'
    click_link 'All Users'

    click_link 'Cancel Request'

    expect(page).to have_content('Your friend request is cancelled')
    expect(page).to have_button('Add As Friend')
  end
end
