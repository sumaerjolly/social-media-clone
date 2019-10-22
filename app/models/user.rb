# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum gender: %i[female male custom]
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, -> { where(confirmed: true) }, class_name: 'Friendship',
                                                                foreign_key: :friend_id, dependent: :destroy
  has_many :confirmed_friendships, -> { where(confirmed: true) }, class_name: 'Friendship',
                                                                  foreign_key: :user_id, dependent: :destroy
  has_many :confirmed_friends, through: :confirmed_friendships, source: :friend
  has_many :confirmed_inverse_friends, through: :inverse_friendships, source: :user
  has_many :pending_friendships, -> { where(confirmed: nil) }, class_name: 'Friendship',
                                                               foreign_key: :user_id, dependent: :destroy
  has_many :pending_inverse_friendships, -> { where(confirmed: nil) }, class_name: 'Friendship',
                                                                       foreign_key: :friend_id, dependent: :destroy
  has_many :confirmed_friends_posts, through: :confirmed_friends, source: :posts
  has_many :conirmed_inverse_friends_posts, through: :confirmed_inverse_friends, source: :posts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  def full_name
    return "#{first_name} #{last_name}".strip if first_name || last_name

    'Annonymous'
  end

  def friends
    confirmed_friends + confirmed_inverse_friends
  end

  def pending_friends
    pending_friendships.map(&:friend)
  end

  def friend_requests
    pending_inverse_friendships.map(&:user)
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
    friendship = pending_inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def mutual_friends(user)
    friends & user.friends unless user.id == id
  end

  def timeline_posts
    confirmed_friends_posts + conirmed_inverse_friends_posts + posts
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name   # assuming the user model has a first name
      user.last_name = auth.info.last_name  #assuming the user model has a last name
      user.gender = auth.extra.raw_info.gender
      user.date_of_birth = 20.years.ago
    end
  end
end
