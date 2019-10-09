# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update show destroy]

  def index
    @post = Post.new
    @posts = current_user.posts
    @comment = @post.comments.build
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = 'Your post was susccessfully created'
      redirect_to authenticated_root_path
    else
      redirect_to authenticated_root_path, :flash => { :error => @post.errors.full_messages.join(', ') }
    end
  end

  def show; end

  def destroy
    if @post.user == current_user
      @post.destroy
      flash[:danger] = 'Post was successfully deleted'
    else
      flash[:alert] = 'You can only delete your own post'
    end
    redirect_to authenticated_root_path
  end

  def edit
    return if @post.user == current_user

    flash[:alert] = 'You can only edit your own post'
    redirect_to authenticated_root_path
  end

  def update
    if @post.user == current_user
      if @post.update(post_params)
        flash[:success] = 'Your post was susccessfully updated'
        redirect_to authenticated_root_path
      else
        render 'edit'
      end
    else
      flash[:alert] = 'You can only edit your own post'
      redirect_to authenticated_root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
