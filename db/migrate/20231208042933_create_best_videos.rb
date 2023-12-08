class CreateBestVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :best_videos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.integer :rank, null: false

      t.timestamps
    end
    add_index :best_videos, [:user_id, :video_id], unique: true
    add_index :best_videos, [:user_id, :rank], unique: true
  end
end
