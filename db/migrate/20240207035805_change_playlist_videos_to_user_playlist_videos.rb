class ChangePlaylistVideosToUserPlaylistVideos < ActiveRecord::Migration[7.0]
  def change
    rename_table :playlist_videos, :user_playlist_videos
  end
end
