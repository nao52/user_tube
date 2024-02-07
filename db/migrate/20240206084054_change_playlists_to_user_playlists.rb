class ChangePlaylistsToUserPlaylists < ActiveRecord::Migration[7.0]
  def change
    rename_table :playlists, :user_playlists
  end
end
