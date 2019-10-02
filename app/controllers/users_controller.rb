class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
      @post = Post.new
      @posts = @user.posts
  end
end
