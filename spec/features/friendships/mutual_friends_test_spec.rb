# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Viewing Mutual Friends' do
  before do
    @user1 = User.create(first_name: 'Sumaer', last_name: 'Doe', email: 'example@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'doe@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @user3 = User.create(first_name: 'John', last_name: 'Doe', email: 'johndoe@example.com',
                         date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @friendship1 = Friendship.create(user: @user1, friend: @user2, confirmed: true)
    @friendship2 = Friendship.create(user: @user3, friend: @user2, confirmed: true)

    login_as(@user1)
  end

  scenario 'A user can see mutual friends with other users ' do
    visit '/'
    click_link 'All Users'

    click_link 'John Doe'

    expect(page).to have_content('Mutual Friends (1)')
    expect(page).to have_link('Jane Doe')
  end

  scenario 'A user cant see mutual friends on his own page ' do
    visit '/'
    click_link 'All Users'

    click_link 'Sumaer Doe'

    expect(page).to_not have_content('Mutual Friends')
    expect(page).to have_content('Friends')
  end
end
