class FriendshipsController < ApplicationController
  def index
    @friendship = Friendship.all
  end

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

  # def destroy
  #   user = User.find(params[:user_id])
  #   @relationship = current_user.friendships.find_by_friend_id(user)
  #   if @relationship.present?
  #     @relationship.destroy
  #   end
  #   redirect_to users_path
  # end

  # def destroy
  #   @relationship = Friendship.find(params[:id])
  #   @relationship.destroy
  #   redirect_to users_path
  # end

  # def destroy
  #   user = User.find(params[:user_id])
  #   friend_request = user.friendships.find_by_friend_id(user.id)

  #   friendship = current_user.friendships.find_by_friend_id(user.id)
  #   if friendship.nil?
  #     friend_request.destroy
  #     flash[:notice] = "Removed friend."
  #   else
  #     friendship.destroy
  #     friend_request.destroy
  #     flash[:notice] = "Removed friendship."
  #   end
  #   redirect_to users_path
  # end

  # def destroy
  #   user = User.find(params[:user_id])
  #   friend = current_user.friendships.find_by_friend_id(user)
  #   if friend
  #     friend.delete
  #     flash.notice = "#{user.name} has been removed as your friend"
  #     redirect_to users_path
  #   else
  #     flash.now[:notice] = 'error occured'
  #   end
  # end

  def destroy
    user = User.find(params[:user_id])
    friend = current_user.friendships.find_by_friend_id(user)
    friend.destroy
    redirect_to user_path(id: current_user.id)
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
