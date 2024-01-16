require 'rails_helper'

RSpec.describe BestVideo, type: :model do
  let(:user) { create(:user) }
  let(:video) { create(:video) }

  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      best_video = user.best_videos.build(video: video, rank: 1)
      expect(best_video).to be_valid
      expect(best_video.errors).to be_empty
    end

    it 'video_idがない場合にバリデーションが機能してinvalidになるか' do
      best_video_without_video_id = user.best_videos.build(video: nil, rank: 1)
      expect(best_video_without_video_id).to_not be_valid
      expect(best_video_without_video_id.errors).to_not be_empty
    end

    it 'rankがない場合にバリデーションが機能してinvalidになるか' do
      best_video_without_rank = user.best_videos.build(video: video, rank: nil)
      expect(best_video_without_rank).to_not be_valid
      expect(best_video_without_rank.errors).to_not be_empty
    end

    it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
      best_video_without_user_id = BestVideo.new(video: video, rank: 1)
      expect(best_video_without_user_id).to_not be_valid
      expect(best_video_without_user_id.errors).to_not be_empty
    end

    it 'ユーザーが同じ動画を選択した場合にバリデーションが機能してinvalidになるか' do
      best_video = user.best_videos.create(video: video, rank: 1)
      duplicate_best_video = best_video.dup
      expect(duplicate_best_video).to be_invalid
      expect(duplicate_best_video.errors).to_not be_empty
    end
  end
end
