require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com', password: 'abc') }
  let(:friend) { User.create(name: 'test2', email: 'test2@gmail.com', password: 'abc') }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: friend.id) }

  context 'Validations' do
    it 'should validate valid relationship' do
      expect(friendship).to be_valid
    end
  end

  context 'Association' do
    it 'should belong to user' do
      t = Friendship.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
    it 'should belong to friend' do
      t = Friendship.reflect_on_association(:friend)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
