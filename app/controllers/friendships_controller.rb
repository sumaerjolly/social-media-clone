# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friendship_params)
    if @friendship.save
      flash[:success] = 'Your friend request was sent'
    else
      flash[:alert] = 'Sorry there was an error'
    end
    redirect_to users_path
  end

  def destroy
    @friend1 = Friendship.where(user_id: params[:format], friend_id: current_user.id)
    @friend2 = Friendship.where(user_id: current_user.id, friend_id: params[:format])

    @friend = @friend1.empty? ? @friend2 : @friend1
    flash[:danger] = 'You are no longer friends' if @friend.delete_all
    redirect_to users_path
  end

  def confirm
    @user = User.find_by(id: params[:format])
    friendship = Friendship.where(user: @user, friend: current_user)
    friendship.update(confirmed: true)
    flash[:success] = 'You are now friends'
    redirect_to users_path
  end

  def reject
    @user = User.find_by(id: params[:format])
    current_user.reject_friend(@user)
    flash[:success] = 'You rejected the friend request'
    redirect_to users_path
  end

  def cancel
    @user = User.find_by(id: params[:format])
    current_user.cancel_friend_request(@user)
    flash[:success] = 'Your friend request is cancelled'
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
