class CreateUserCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_categories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :user_categories, [:user_id, :category_id], unique: true
  end
end
