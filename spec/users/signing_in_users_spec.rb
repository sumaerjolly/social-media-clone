# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signing in a User' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
  end

  scenario 'with valid credentials' do
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(@user.full_name.to_s)
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end
end
