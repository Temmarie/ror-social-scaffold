require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:user2) { User.create(name: 'test2', email: 'email2@email.com', password: 'abc123') }
  let(:friend1) { user1.friendships.create(friend_id: 2) }

  context 'check associations' do
    it 'frienship belongs to a user' do
      user1
      user2
      friend1
      expect(Friendship.first.user_id).not_to be_nil
    end
  end
end
