class CreateChannelPlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_playlists do |t|
      t.references :channel, null: false, foreign_key: true
      t.string :playlist_id, index: { unique: true }
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
