class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :playlist_id, null: false, index: { unique: true }
      t.string :title
      t.text :description
      t.boolean :is_public, null: false, default: false

      t.timestamps
    end
  end
end
