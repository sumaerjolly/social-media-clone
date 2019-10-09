class CommentsController < ApplicationController
    before_action :set_post

    def create
        unless current_user
            flash[:alert] = "Please sign in or sign up first"
            redirect_to new_user_session_path
        else
            @comment = @post.comments.build(comment_params)
            @comment.user = current_user

            if @comment.save
                flash[:notice] = "Comment has been created"
            else 
                flash[:alert] = "Comment could not be created"
            end
            redirect_to authenticated_root_path
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
              render 'edit'
            end
        else
            flash[:alert] = 'You can only edit your own post'
            redirect_to authenticated_root_path
        end
    end
    
    def destroy
        @comment = @post.comments.find(params[:comment_id])
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
