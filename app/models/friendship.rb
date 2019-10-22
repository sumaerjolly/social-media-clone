# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  validate :not_self
  validate :inverse_not_allowed

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def inverse_not_allowed
    return unless Friendship.where(user_id: friend_id, friend_id: user_id).exists?

    errors.add(:unique_friendship, 'Already friends!')
  end
end
