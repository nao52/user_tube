require 'rails_helper'

RSpec.describe ContentFavorite, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      content_favorite = build(:content_favorite)
      expect(content_favorite).to be_valid
      expect(content_favorite.errors).to be_empty
    end

    it "ユーザーIDがない場合にバリデーションが機能してinvalidになるか" do
      content_favorite_without_user_id = build(:content_favorite, user: nil)
      expect(content_favorite_without_user_id).to be_invalid
      expect(content_favorite_without_user_id.errors).to_not be_empty
    end

    it "コンテンツIDがない場合にバリデーションが機能してinvalidになるか" do
      content_favorite_without_content_id = build(:content_favorite, content: nil)
      expect(content_favorite_without_content_id).to be_invalid
      expect(content_favorite_without_content_id.errors).to_not be_empty
    end

    it "ユーザーIDとコンテンツIDの組み合わせが既に存在している場合にバリデーションが機能してinvalidになるか" do
      content_favorite = create(:content_favorite)
      duplicate_content_favorite = content_favorite.dup
      expect(duplicate_content_favorite).to be_invalid
      expect(duplicate_content_favorite.errors).to_not be_empty
    end
  end
end
