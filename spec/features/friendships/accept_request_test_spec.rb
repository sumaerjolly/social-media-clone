# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Accepting Friend request' do
  before do
    @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'example@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'doe@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user2)
    @friendship = Friendship.create(user: @user1, friend: @user2)
  end

  scenario 'A friend request is accepted' do
    visit '/'
    click_link 'All Users'

    click_link 'Accept'

    expect(page).to have_content('You are now friends')
    expect(page).to have_link('Unfriend')
  end
end
