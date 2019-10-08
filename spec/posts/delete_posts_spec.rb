# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Deleting a post' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)
    @post = Post.create(title: 'Test', body: 'Body Test', user: @user)
  end

  scenario 'A user deletes a post' do
    visit '/'

    click_link 'Delete'

    expect(page).to have_content('Post was successfully deleted')
    expect(current_path).to eq(authenticated_root_path)
  end
end
