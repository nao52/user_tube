class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.integer :title, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
