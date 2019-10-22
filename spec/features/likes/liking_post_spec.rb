# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Liking a post' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'example@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)
    @post = Post.create(title: 'Test', body: 'Body Test', user: @user)
  end

  scenario 'A user can like a post' do
    visit '/'

    click_link 'Like'

    expect(page).to have_content('You have successfully liked a post')
  end
end
