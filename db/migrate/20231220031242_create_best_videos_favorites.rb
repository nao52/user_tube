class CreateBestVideosFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :best_videos_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :best_video, null: false, foreign_key: true

      t.timestamps
    end
    add_index :best_videos_favorites, [:user_id, :best_video_id], unique: true
  end
end
