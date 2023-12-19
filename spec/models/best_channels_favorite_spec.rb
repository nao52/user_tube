require 'rails_helper'

RSpec.describe BestChannelsFavorite, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      best_channels_favorite = build(:best_channels_favorite)
      expect(best_channels_favorite).to be_valid
      expect(best_channels_favorite.errors).to be_empty
    end

    it "user_idがない場合にバリデーションが機能してinvalidになるか" do
      best_channels_favorite_without_user_id = build(:best_channels_favorite, user: nil)
      expect(best_channels_favorite_without_user_id).to be_invalid
      expect(best_channels_favorite_without_user_id.errors).to_not be_empty
    end

    it "best_channel_idがない場合にバリデーションが機能してinvalidになるか" do
      best_channels_favorite_without_best_channel_id = build(:best_channels_favorite, best_channel: nil)
      expect(best_channels_favorite_without_best_channel_id).to be_invalid
      expect(best_channels_favorite_without_best_channel_id.errors).to_not be_empty
    end
  end
end
