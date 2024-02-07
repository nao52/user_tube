require 'rails_helper'

RSpec.describe ChannelPlaylistVideo, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      channel_playlist_video = build(:channel_playlist_video)
      expect(channel_playlist_video).to be_valid
      expect(channel_playlist_video.errors).to be_empty
    end

    it 'video_idがない場合にバリデーションが機能してinvalidになるか' do
      channel_playlist_video_without_video_id = build(:channel_playlist_video, video_id: nil)
      expect(channel_playlist_video_without_video_id).to be_invalid
      expect(channel_playlist_video_without_video_id.errors).to_not be_empty
    end

    it 'channel_playlist_idがない場合にバリデーションが機能してinvalidになるか' do
      channel_playlist_video_without_playlist_id = build(:channel_playlist_video, channel_playlist_id: nil)
      expect(channel_playlist_video_without_playlist_id).to be_invalid
      expect(channel_playlist_video_without_playlist_id.errors).to_not be_empty
    end
  end
end
