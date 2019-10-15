class FriendshipsController < ApplicationController

    def create
        @friendship = current_user.friendships.build(friendship_params)
        if @friendship.save
            flash[:success] = 'Your friend request was sent'
        else 
            flash[:alert] = "Sorry there was an error"
        end
        redirect_to users_path
    end

    def destroy
        @friend1 = Friendship.where(user_id: params[:format], friend_id: current_user.id)
        @friend2 = Friendship.where(user_id: current_user.id, friend_id: params[:format])
        if @friend1.empty?
            @friend = @friend2
        else 
            @friend = @friend1
        end
        # byebug
        flash[:danger] = 'You are no longer friends' if @friend.delete_all
        redirect_to users_path
    end


    private 

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
    end 
end
