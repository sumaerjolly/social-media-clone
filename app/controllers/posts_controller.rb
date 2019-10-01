class PostsController < ApplicationController
    before_action :set_post , only: [:edit, :update, :show, :destroy]

    def index
        @post = Post.new
        @posts = current_user.posts
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @posts = current_user.posts
        @post.user = current_user
        if @post.save
            flash[:success] = "Your post was susccessfully created"
            redirect_to authenticated_root_path
        else 
            flash.now[:alert] = "Your post could not be created"
            render 'index'
        end
    end 

    def show
    end

    def destroy
        unless @post.user == current_user
            flash[:alert] = "You can only edit your own post"
            redirect_to authenticated_root_path
        else 
            @post.destroy 
            flash[:danger] = "Post was successfully deleted"
            redirect_to authenticated_root_path
        end
    end

    def edit
        unless @post.user == current_user
            flash[:alert] = "You can only edit your own post"
            redirect_to authenticated_root_path
        end
    end 

    def update
        unless @post.user == current_user
            flash[:alert] = "You can only edit your own post"
            redirect_to authenticated_root_path
        else 
            if @post.update(post_params)
                flash[:success] = "Your post was susccessfully updated"
                redirect_to authenticated_root_path
            else 
                render 'edit'
            end
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
