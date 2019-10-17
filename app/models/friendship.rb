# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  validate :not_self

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end
end
