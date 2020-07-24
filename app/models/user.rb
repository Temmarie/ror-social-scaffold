<<<<<<< HEAD
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.status }
    friends_arrayb = inverse_friendships.map { |friendship| friendship.user if friendship.status }
    friends_array.concat(friends_arrayb)
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
=======
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.status }
    friends_arrayb = inverse_friendships.map { |friendship| friendship.user if friendship.status }
    friends_array.concat(friends_arrayb)
    friends_array.compact
  end

  def send_invitation(user_id)
    @friendship = Friendship.new(user_id: id, friend_id: user_id)
    @friendship.status = false
    @friendship.save
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.where(user_id: user).first
    friendship.confirmed = true
    friendship.save
  end

  def friend_invites(user_id)
    friendship = friendships.where(friend_id: user_id).first
    true if friendship && friendship.status == false
  end

  def receive_invitation(user_id)
    friendship = inverse_friendships.where(user_id: user_id).first
    true if friendship && friendship.status == false
  end

  def reject_friend(user)
    friendship = inverse_friendships.where(user_id: user).first
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
>>>>>>> 98cdd443640855316a5bf5e6a00f4b0b7a3bbb0a
