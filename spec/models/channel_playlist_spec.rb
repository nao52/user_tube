require 'rails_helper'

RSpec.describe ChannelPlaylist, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      playlist = build(:channel_playlist)
      expect(playlist).to be_valid
      expect(playlist.errors).to be_empty
    end

    it "プレイリストIDがない場合にバリデーションが機能してinvalidになるか" do
      playlist_without_playlist_id = build(:channel_playlist, playlist_id: "")
      expect(playlist_without_playlist_id).to be_invalid
      expect(playlist_without_playlist_id.errors).to_not be_empty
    end

    it "プレイリストIDがすでに登録されている場合にvalidationが機能してinvalidになるか" do
      playlist = create(:channel_playlist)
      duplicate_playlist = playlist.dup
      expect(duplicate_playlist).to be_invalid
      expect(duplicate_playlist.errors).to_not be_empty
    end

    it "チャンネルIDがない場合にバリデーションが機能してinvalidになるか" do
      playlist_without_channel_id = build(:channel_playlist, channel: nil)
      expect(playlist_without_channel_id).to be_invalid
      expect(playlist_without_channel_id.errors).to_not be_empty
    end

    it "タイトルがない場合にバリデーションが機能してinvalidになるか" do
      playlist_without_title = build(:channel_playlist, title: nil)
      expect(playlist_without_title).to be_invalid
      expect(playlist_without_title.errors).to_not be_empty
    end
  end
end
