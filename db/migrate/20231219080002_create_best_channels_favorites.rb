class CreateBestChannelsFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :best_channels_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :best_channel, null: false, foreign_key: true

      t.timestamps
    end
    add_index :best_channels_favorites, [:user_id, :best_channel_id], unique: true
  end
end
