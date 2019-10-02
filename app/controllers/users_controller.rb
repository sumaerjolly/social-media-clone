class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
      @post = Post.new
      @posts = current_user.posts
  end
end
