# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signing out a signed in users' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'example@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  scenario do
    visit '/'
    click_link 'Sign out'
    expect(page).not_to have_content('Sign out')
  end
end
