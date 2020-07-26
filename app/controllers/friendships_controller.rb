class FriendshipsController < ApplicationController
  def send_request
    if current_user.send_invitation(params[:user_id])
      flash.notice = 'Friend request sent'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def accept_invitation
    if current_user.confirm_friend(params[:user_id])
      flash.notice = 'friend accepted'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def reject_invitation
    current_user.reject_friend(params[:user_id])
    redirect_to users_path
  end

  def pending_invitation
    @pending_friends = current_user.pending_invites
  end

  def remove_friend
    friend = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)
    inverse_friend = Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
    friend&.delete
    inverse_friend&.delete
  end

  def destroy
    user = User.find(params[:user_id])
    friend = current_user.friendships.find_by_friend_id(user)
    if friend
      friend.delete
      flash.notice = "#{user.name} has been removed as your friend"
      redirect_to users_path
    end
  end

  # def destroy
  #   @friendship = current_user.friendships.find_by_friend_id(user)
  #   @friendship.destroy
  #   flash[:notice] = "Removed friendship."
  #   redirect_to current_user
  # end

end
