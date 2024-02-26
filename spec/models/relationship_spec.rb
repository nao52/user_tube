require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower_user) { create(:user) }
  let(:followed_user) { create(:user) }

  describe 'バリデーションチェック' do    
    it '設定したすべてのバリデーションが機能しているか' do
      relationship = Relationship.new(follower_id: follower_user.id, followed_id: followed_user.id)
      expect(relationship).to be_valid
      expect(relationship.errors).to be_empty
    end

    it 'followed_idがない場合にバリデーションが機能してinvalidになるか' do
      relationship_without_followed_id = Relationship.new(follower_id: follower_user.id, followed_id: nil)
      expect(relationship_without_followed_id).to be_invalid
      expect(relationship_without_followed_id.errors).to_not be_empty
    end

    it 'follower_idがない場合にバリデーションが機能してinvalidになるか' do
      relationship_without_follower_id = Relationship.new(follower_id: nil, followed_id: followed_user.id)
      expect(relationship_without_follower_id).to be_invalid
      expect(relationship_without_follower_id.errors).to_not be_empty
    end

    it 'フォローIDとフォロワーIDの組み合わせが既に存在している場合にバリデーションが機能してinvalidになるか' do
      relationship = Relationship.create(follower_id: follower_user.id, followed_id: followed_user.id)
      duplicate_relationship = relationship.dup
      expect(duplicate_relationship).to be_invalid
      expect(duplicate_relationship.errors).to_not be_empty
    end

    it 'フォローIDとフォロワーIDの組み合わせに同じユーザーIDが使用されている場合にバリデーションが機能してinvalidになるか' do
      relationship_with_same_user_id = Relationship.new(follower_id: follower_user.id, followed_id: follower_user.id)
      expect(relationship_with_same_user_id).to be_invalid
      expect(relationship_with_same_user_id.errors.full_messages).to include "自分自身をフォローすることはできません"
    end
  end
end
