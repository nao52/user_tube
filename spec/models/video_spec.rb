require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      video = build(:video)
      expect(video).to be_valid
      expect(video.errors).to be_empty
    end

    it 'ビデオIDがない場合にバリデーションが機能してinvalidになるか' do
      video_without_video_id = build(:video, video_id: "")
      expect(video_without_video_id).to be_invalid
      expect(video_without_video_id.errors).to_not be_empty
    end

    it 'ビデオIDがすでに登録されている場合にvalidationが機能してinvalidになるか' do
      video = create(:video)
      duplicate_video = video.dup
      expect(duplicate_video).to be_invalid
      expect(duplicate_video.errors).to_not be_empty
    end

    it 'タイトルがない場合にバリデーションが機能してinvalidになるか' do
      video_without_title = build(:video, title: "")
      expect(video_without_title).to be_invalid
      expect(video_without_title.errors).to_not be_empty
    end

    it 'カテゴリーIDがない場合にバリデーションが機能してinvalidになるか' do
      video_without_category_id = build(:video, category: nil)
      expect(video_without_category_id).to be_invalid
      expect(video_without_category_id.errors).to_not be_empty
    end

    it 'チャンネルIDがない場合にバリデーションが機能してinvalidになるか' do
      video_without_channel_id = build(:video, channel: nil)
      expect(video_without_channel_id).to be_invalid
      expect(video_without_channel_id.errors).to_not be_empty
    end
  end
end
