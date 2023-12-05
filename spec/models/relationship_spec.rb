require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe 'バリデーションチェック' do    
    it '設定したすべてのバリデーションが機能しているか' do
      relationship = Relationship.new(follower_id: user1.id, followed_id: user2.id)
      expect(relationship).to be_valid
      expect(relationship.errors).to be_empty
    end

    it 'follower_idがない場合にバリデーションが機能してinvalidになるか' do
      relationship_without_follower_id = Relationship.new(follower_id: nil, followed_id: user2.id)
      expect(relationship_without_follower_id).to be_invalid
    end

    it 'followed_idがない場合にバリデーションが機能してinvalidになるか' do
      relationship_without_followed_id = Relationship.new(follower_id: user1.id, followed_id: nil)
      expect(relationship_without_followed_id).to be_invalid
    end
  end
end
