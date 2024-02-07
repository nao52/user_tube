class RenamePlaylistToUserPlaylist < ActiveRecord::Migration[7.0]
  def change
    rename_column :playlist_videos, :playlist_id, :user_playlist_id
  end
end
