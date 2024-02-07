class CreateChannelPlaylistVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_playlist_videos do |t|
      t.references :channel_playlist, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
