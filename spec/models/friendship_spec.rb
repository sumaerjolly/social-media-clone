# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Friendship, type: :model do
  describe 'validation' do 
    it 'ensures presence of a user' do
      @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'wohoo@example.com',
                          date_of_birth: '2001-11-5', gender: 1, password: 'password')
      @request = Friendship.new(user: nil, friend: @user1)
      expect(@request.save).to eq(false)
    end
    it 'ensures presence of a friend' do 
      @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'wohoo@example.com',
                          date_of_birth: '2001-11-5', gender: 1, password: 'password')
      @request = Friendship.new(user: @user1, friend: nil)
      expect(@request.save).to eq(false)
    end
  end
  describe 'uniqueness of friendship' do 
    context 'friendship between same users' do
      it 'ensures uniqueness of friend for a particular user' do
        @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'wohoo@example.com',
                            date_of_birth: '2001-11-5', gender: 1, password: 'password')
        @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'ola@example.com',
                            date_of_birth: '2001-11-5', gender: 1, password: 'password')
        @request = Friendship.create(user: @user1, friend: @user2)
        @request1 = Friendship.new(user: @user1, friend: @user2)
        expect(@request1.save).to eq(false)
      end
    end
    context 'friendship between a user and himself' do 
      it 'ensures a user cant add himslef as a friend  ' do
        @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'wohoo@example.com',
                             date_of_birth: '2001-11-5', gender: 1, password: 'password')
        @request1 = Friendship.new(user: @user1, friend: @user1)
        expect(@request1.save).to eq(false)
      end
    end
    context 'friendship between a user and friend where the user and friends are inverse' do 
      it 'ensures once a friendship is created you cant add a duplicate inverse friendship' do
        @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'wohoo@example.com',
          date_of_birth: '2001-11-5', gender: 1, password: 'password')
        @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'ola@example.com',
                  date_of_birth: '2001-11-5', gender: 1, password: 'password')
        @request = Friendship.create(user: @user1, friend: @user2)
        @request1 = Friendship.new(user: @user2, friend: @user1)
        expect(@request1.save).to eq(false)
      end
    end
    context 'friendship between valid users' do 
      it 'ensures that a friendship that is valid gets saved' do 
        @user1 = User.create(first_name: 'Raja', last_name: 'Doe', email: 'wohoo@example.com',
                            date_of_birth: '2001-11-5', gender: 1, password: 'password')
        @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'ola@example.com',
                            date_of_birth: '2001-11-5', gender: 1, password: 'password')
        @request = Friendship.new(user: @user1, friend: @user2)
        expect(@request.save).to eq(true)
      end   
    end
  end 
  
end