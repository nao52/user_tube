class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :video_url, null: false
      t.integer :rating, null: false
      t.text :feedback, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
