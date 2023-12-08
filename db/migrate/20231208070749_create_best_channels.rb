class CreateBestChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :best_channels do |t|
      t.references :user, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true
      t.integer :rank, null: false

      t.timestamps
    end
    add_index :best_channels, [:user_id, :channel_id], unique: true
    add_index :best_channels, [:user_id, :rank], unique: true
  end
end
