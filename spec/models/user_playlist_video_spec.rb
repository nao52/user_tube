require 'rails_helper'

RSpec.describe UserPlaylistVideo, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user_playlist_video = build(:user_playlist_video)
      expect(user_playlist_video).to be_valid
      expect(user_playlist_video.errors).to be_empty
    end

    it '動画IDがない場合にバリデーションが機能してinvalidになるか' do
      user_playlist_video_without_video_id = build(:user_playlist_video, video_id: nil)
      expect(user_playlist_video_without_video_id).to be_invalid
      expect(user_playlist_video_without_video_id.errors).to_not be_empty
    end

    it 'ユーザープレイリストIDがない場合にバリデーションが機能してinvalidになるか' do
      user_playlist_video_without_playlist_id = build(:user_playlist_video, user_playlist_id: nil)
      expect(user_playlist_video_without_playlist_id).to be_invalid
      expect(user_playlist_video_without_playlist_id.errors).to_not be_empty
    end

    it '動画IDとユーザープレイリストIDの組み合わせが既に存在している場合にバリデーションが機能してinvalidになるか' do
      user_playlist_video = create(:user_playlist_video)
      duplicate_user_playlist_video = user_playlist_video.dup
      expect(duplicate_user_playlist_video).to be_invalid
      expect(duplicate_user_playlist_video.errors).to_not be_empty
    end
  end
end
