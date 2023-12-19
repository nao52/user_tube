class AddIndexToContentFavorite < ActiveRecord::Migration[7.0]
  def change
    add_index :content_favorites, [:user_id, :content_id], unique: true
  end
end
