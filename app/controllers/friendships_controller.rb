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
        @friend = @friend1 || @friend2
        byebug
        if @friend.delete_all
            flash[:success]="You are no longer friends"
        end
        redirect_to users_path
    end


    private 

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
    end 
end
