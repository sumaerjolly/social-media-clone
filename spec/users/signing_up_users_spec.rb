# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signing up a User' do
  scenario 'With valid credentials' do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'First name', with: 'john'
    fill_in 'Last name', with: 'doe'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('You have signed up successfully')
  end

  scenario 'With invalid credentials' do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: ''
    fill_in 'First name', with: ''
    fill_in 'Last name', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_button 'Sign up'
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end
