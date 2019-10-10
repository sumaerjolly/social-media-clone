# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post

  def create
    if current_user
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        flash[:notice] = 'Comment has been created'
        redirect_to authenticated_root_path
      else
        redirect_to authenticated_root_path, flash: { error: @comment.errors.full_messages.join(', ') }
      end
    else
      flash[:alert] = 'Please sign in or sign up first'
      redirect_to new_user_session_path
      end
  end

  def edit
    @comment = @post.comments.find(params[:id])
    if @comment.user != current_user
      flash[:alert] = 'You can only edit your own comment'
      redirect_to authenticated_root_path
    end
  end

  def update
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      if @comment.update(comment_params)
        flash[:success] = 'Your comment was susccessfully updated'
        redirect_to authenticated_root_path
      else
        flash.now[:alert] = 'Your comment could not be updated'
        render 'edit'
      end
    else
      flash[:alert] = 'You can only edit your own post'
      redirect_to authenticated_root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      flash[:danger] = 'Comment was successfully deleted'
    else
      flash[:alert] = 'You can only delete your own comment'
    end
    redirect_to authenticated_root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
