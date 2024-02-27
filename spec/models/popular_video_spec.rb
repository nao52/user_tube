require 'rails_helper'

RSpec.describe PopularVideo, type: :model do
  describe 'バリデーションチェック' do    
    it '設定したすべてのバリデーションが機能しているか' do
      popular_video = build(:popular_video)
      expect(popular_video).to be_valid
      expect(popular_video.errors).to be_empty
    end

    it '動画IDがない場合にバリデーションが機能してinvalidになるか' do
      popular_video_without_video_id = build(:popular_video, video: nil)
      expect(popular_video_without_video_id).to be_invalid
      expect(popular_video_without_video_id.errors).to_not be_empty
    end

    it 'ユーザーIDがない場合にバリデーションが機能してinvalidになるか' do
      popular_video_without_user_id = build(:popular_video, user: nil)
      expect(popular_video_without_user_id).to be_invalid
      expect(popular_video_without_user_id.errors).to_not be_empty
    end

    it '動画IDとユーザーIDの組み合わせが既に存在している場合にバリデーションが機能してinvalidになるか' do
      popular_video = create(:popular_video)
      duplicate_popular_video = popular_video.dup
      expect(duplicate_popular_video).to be_invalid
      expect(duplicate_popular_video.errors).to_not be_empty
    end
  end

  describe 'デフォルト値の確認' do
    let(:popular_video) { build(:popular_video) }

    it '公開設定のデフォルト値がfalse(非公開)になっているか' do
      expect(popular_video.is_public).to be_falsey
    end
  end
end
