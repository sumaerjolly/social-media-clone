# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before do
    @john = User.create(first_name: 'John', last_name: 'Doe', email: 'example@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @jane = User.create(first_name: 'Jane', last_name: 'Doe', email: 'doe@example.com',
                        date_of_birth: '2001-11-5', gender: 1, password: 'password')
    @post = Post.create(title: 'Test', body: 'Body Test', user: @john)
  end

  describe 'GET/posts/:id/edit' do
    context 'with non signed in user' do
      before { get "/posts/#{@post.id}/edit" }

      it 'redirects to do the signup' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non creator' do
      before do
        login_as(@jane)
        get "/posts/#{@post.id}/edit"
      end
      it 'redirects to do the homepage' do
        expect(response.status).to eq 302
        flash_message = 'You can only edit your own post'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is the creator' do
      before do
        login_as(@john)
        get "/posts/#{@post.id}/edit"
      end
      it 'sucessfully edits articles' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE/posts/:id' do
    context 'with non signed in user' do
      before { delete "/posts/#{@post.id}" }

      it 'redirects to do the signup' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non creator' do
      before do
        login_as(@jane)
        delete "/posts/#{@post.id}"
      end
      it 'redirects to do the homepage' do
        expect(response.status).to eq 302
        flash_message = 'You can only delete your own post'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is the creator' do
      before do
        login_as(@john)
        delete "/posts/#{@post.id}"
      end
      it 'sucessfully deletes articles' do
        expect(response.status).to eq 302
        flash_message = 'Post was successfully deleted'
        expect(flash[:danger]).to eq flash_message
      end
    end
  end
end
