# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
    @comment = @post.comments.build
    @comments = @post.comments
    @like = @post.likes.build
    @likes = @post.likes
    @friendship = current_user.friendships.build
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
    @friendship = current_user.friendships.build

  end
end
