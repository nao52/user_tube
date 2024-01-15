require 'rails_helper'

RSpec.describe PlaylistVideo, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      playlist_video = build(:playlist_video)
      expect(playlist_video).to be_valid
      expect(playlist_video.errors).to be_empty
    end

    it 'video_idがない場合にバリデーションが機能してinvalidになるか' do
      playlist_video_without_video_id = build(:playlist_video, video_id: nil)
      expect(playlist_video_without_video_id).to be_invalid
      expect(playlist_video_without_video_id.errors).to_not be_empty
    end

    it 'playlist_idがない場合にバリデーションが機能してinvalidになるか' do
      playlist_video_without_playlist_id = build(:playlist_video, playlist_id: nil)
      expect(playlist_video_without_playlist_id).to be_invalid
      expect(playlist_video_without_playlist_id.errors).to_not be_empty
    end
  end
end
