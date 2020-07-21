require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create(name: 'Becky W', email: 'becky@email.com', password: 'rebecca') }
  let(:friend) { User.create(name: 'Temmarie', email: 'tam@email.com', password: 'tamara') }
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
