require 'rails_helper'

RSpec.describe UserPlaylist, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      playlist = build(:user_playlist)
      expect(playlist).to be_valid
      expect(playlist.errors).to be_empty
    end

    it "プレイリストIDがない場合にバリデーションが機能してinvalidになるか" do
      playlist_without_playlist_id = build(:user_playlist, playlist_id: "")
      expect(playlist_without_playlist_id).to be_invalid
      expect(playlist_without_playlist_id.errors).to_not be_empty
    end

    it "プレイリストIDがすでに登録されている場合にvalidationが機能してinvalidになるか" do
      playlist = create(:user_playlist)
      duplicate_playlist = playlist.dup
      expect(duplicate_playlist).to be_invalid
      expect(duplicate_playlist.errors).to_not be_empty
    end

    it "ユーザーIDがすでに登録されている場合にvalidationが機能してinvalidになるか" do
      playlist_without_user_id = build(:user_playlist, user: nil)
      expect(playlist_without_user_id).to be_invalid
      expect(playlist_without_user_id.errors).to_not be_empty
    end

    it "タイトルがない場合にバリデーションが機能してinvalidになるか" do
      playlist_without_title = build(:user_playlist, title: "")
      expect(playlist_without_title).to be_invalid
      expect(playlist_without_title.errors).to_not be_empty
    end
  end

  describe "デフォルト値の確認" do
    let(:playlist) { build(:user_playlist) }

    it "公開設定のデフォルト値がfalseになっているか" do
      expect(playlist.is_public).to be_falsey
    end
  end
end
