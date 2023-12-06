require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower_user) { create(:user) }
  let(:followed_user) { create(:user) }

  describe 'バリデーションチェック' do    
    it '設定したすべてのバリデーションが機能しているか' do
      relationship = follower_user.active_relationships.build(followed_id: followed_user.id)
      expect(relationship).to be_valid
      expect(relationship.errors).to be_empty
    end

    it 'followed_idがない場合にバリデーションが機能してinvalidになるか' do
      relationship_without_followed_id = follower_user.active_relationships.build(followed_id: nil)
      expect(relationship_without_followed_id).to be_invalid
      expect(relationship_without_followed_id.errors).to_not be_empty
    end

    it 'follower_idがない場合にバリデーションが機能してinvalidになるか' do
      relationship_without_follower_id = Relationship.new(follower_id: nil, followed_id: followed_user.id)
      expect(relationship_without_follower_id).to be_invalid
      expect(relationship_without_follower_id.errors).to_not be_empty
    end
  end
end
