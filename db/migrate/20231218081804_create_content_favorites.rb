class CreateContentFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :content_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
