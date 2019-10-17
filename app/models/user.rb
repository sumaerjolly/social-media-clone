# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum gender: %i[female male custom]
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    return "#{first_name} #{last_name}".strip if first_name || last_name

    'Annonymous'
  end

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end

    friends_array += inverse_friendships.map do |friendship|
      friendship.user if friendship.confirmed
    end

    friends_array.compact
  end

  def pending_friends
    friendships.map { |f| f.friend unless f.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend_requests
    inverse_friendships.map { |f| f.user unless f.confirmed }.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def sent_request?(user)
    pending_friends.include?(user)
  end

  def cancel_friend_request(user)
    friendship = friendships.find { |f| f.friend_id == user.id }
    friendship.destroy
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def mutual_friends(user)
    self.friends & user.friends unless user.id == self.id 
  end
end
