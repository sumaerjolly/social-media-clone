# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Listing Posts' do
  before do
    @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    login_as(@user)
    @post1 = Post.create(title: 'Test', body: 'Body Test', user: @user)
    @post2 = Post.create(title: 'Second', body: 'Body Second', user: @user)
  end

  scenario 'A user lists all posts' do
    visit '/'

    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post1.body)
    expect(page).to have_content(@post1.user.full_name)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post2.body)
    expect(page).to have_content(@post2.user.full_name)
  end
end
