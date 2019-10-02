class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
      @post = Post.new
      @posts = @user.posts
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
end
