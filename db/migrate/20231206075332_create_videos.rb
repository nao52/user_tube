class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :video_id,    null: false, index: { unique: true }
      t.string :title,       null: false
      t.text :description
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
