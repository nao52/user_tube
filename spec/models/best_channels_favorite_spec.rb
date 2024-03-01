require 'rails_helper'

RSpec.describe BestChannelsFavorite, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      best_channels_favorite = build(:best_channels_favorite)
      expect(best_channels_favorite).to be_valid
      expect(best_channels_favorite.errors).to be_empty
    end

    it "ユーザーIDがない場合にバリデーションが機能してinvalidになるか" do
      best_channels_favorite_without_user_id = build(:best_channels_favorite, user: nil)
      expect(best_channels_favorite_without_user_id).to be_invalid
      expect(best_channels_favorite_without_user_id.errors).to_not be_empty
    end

    it "ベストチャンネルIDがない場合にバリデーションが機能してinvalidになるか" do
      best_channels_favorite_without_best_channel_id = build(:best_channels_favorite, best_channel: nil)
      expect(best_channels_favorite_without_best_channel_id).to be_invalid
      expect(best_channels_favorite_without_best_channel_id.errors).to_not be_empty
    end

    it "ユーザーが同じベストチャンネルをお気に入りしようとした場合にバリデーションが機能してinvalidになるか" do
      best_channels_favorite = create(:best_channels_favorite)
      duplicate_best_channels_favorite = best_channels_favorite.dup
      expect(duplicate_best_channels_favorite).to be_invalid
      expect(duplicate_best_channels_favorite.errors).to_not be_empty
    end
  end
end
