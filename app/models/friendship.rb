class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def destroy_duplicates
    inverse = Friendship.find_by(user_id: friend, friend_id: user)
    destroy
    inverse.destroy
  end
end
