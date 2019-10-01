class PostsController < ApplicationController
    before_action :set_post , only: [:edit, :update, :show, :destroy]

    def index
        @post = Post.new
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            flash[:success] = "Your post was susccessfully created"
            redirect_to authenticated_root_path
        else 
            render 'new'
        end
    end 

    def show
    end

    def destroy
        @post.destroy 
        flash[:danger] = "Post was successfully deleted"
        redirect_to authenticated_root_path
    end

    def edit
    end 

    def update
        if @post.update(post_params)
            flash[:success] = "Your post was susccessfully updated"
            redirect_to authenticated_root_path
        else 
            render 'edit'
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
