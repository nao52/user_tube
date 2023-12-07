require 'rails_helper'

RSpec.describe PopularVideo, type: :model do
  let(:user) { create(:user) }
  let(:video) { create(:video) }

  describe 'バリデーションチェック' do    
    it '設定したすべてのバリデーションが機能しているか' do
      popular_video = user.popular_videos.build(video: video)
      expect(popular_video).to be_valid
      expect(popular_video.errors).to be_empty
    end

    it 'video_idがない場合にバリデーションが機能してinvalidになるか' do
      popular_video_without_video_id = user.popular_videos.build(video: nil)
      expect(popular_video_without_video_id).to be_invalid
      expect(popular_video_without_video_id.errors).to_not be_empty
    end

    it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
      popular_video_without_user_id = PopularVideo.new(user: nil, video: video)
      expect(popular_video_without_user_id).to be_invalid
      expect(popular_video_without_user_id.errors).to_not be_empty
    end
  end
end
