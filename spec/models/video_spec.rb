require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      video = build(:video)
      expect(video).to be_valid
      expect(video.errors).to be_empty
    end

    it 'video_idがない場合にバリデーションが機能してinvalidになるか' do
      video_without_video_id = build(:video, video_id: "")
      expect(video_without_video_id).to be_invalid
      expect(video_without_video_id.errors).to_not be_empty
    end

    it 'titleがない場合にバリデーションが機能してinvalidになるか' do
      video_without_title = build(:video, title: "")
      expect(video_without_title).to be_invalid
      expect(video_without_title.errors).to_not be_empty
    end

    it 'channel_idがない場合にバリデーションが機能してinvalidになるか' do
      video_without_channel_id = build(:video, channel: nil)
      expect(video_without_channel_id).to be_invalid
      expect(video_without_channel_id.errors).to_not be_empty
    end

    it 'category_idがない場合にバリデーションが機能してinvalidになるか' do
      video_without_category_id = build(:video, category: nil)
      expect(video_without_category_id).to be_invalid
      expect(video_without_category_id.errors).to_not be_empty
    end
  end
end
