class LikesController < ApplicationController
    before_action :find_post
    before_action :find_like, only: [:destroy]

    def create
        if already_liked?
            flash[:notice] = "You can't like more than once"
        else  
            @post.likes.create(user_id: current_user.id)
            flash[:success] = "You have succesfully liked a post"
        end
        redirect_to authenticated_root_path
    end 

    def destroy
        if !(already_liked?)
            flash[:notice] = "Cannot unlike"
        else
            @like.destroy
            flash[:success] = "You have succesfully unliked a post"
        end
        redirect_to authenticated_root_path
    end 

    private

    def find_post
        @post = Post.find(params[:post_id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, post_id:
        params[:post_id]).exists?
    end

    def find_like
        @like = @post.likes.find(params[:id])
    end
end
