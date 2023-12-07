class CreatePopularVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :popular_videos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.boolean :is_public, null: false, default: false

      t.timestamps
    end
  end
end
