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
    end


    private 

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
    end 
end
