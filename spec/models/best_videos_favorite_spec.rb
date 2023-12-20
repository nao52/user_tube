require 'rails_helper'

RSpec.describe BestVideosFavorite, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      best_videos_favorite = build(:best_videos_favorite)
      expect(best_videos_favorite).to be_valid
      expect(best_videos_favorite.errors).to be_empty
    end

    it "user_idがない場合にバリデーションが機能してinvalidになるか" do
      best_videos_favorite_without_user_id = build(:best_videos_favorite, user: nil)
      expect(best_videos_favorite_without_user_id).to be_invalid
      expect(best_videos_favorite_without_user_id.errors).to_not be_empty
    end

    it "best_video_idがない場合にバリデーションが機能してinvalidになるか" do
      best_videos_favorite_without_best_video_id = build(:best_videos_favorite, best_video: nil)
      expect(best_videos_favorite_without_best_video_id).to be_invalid
      expect(best_videos_favorite_without_best_video_id.errors).to_not be_empty
    end
  end
end
