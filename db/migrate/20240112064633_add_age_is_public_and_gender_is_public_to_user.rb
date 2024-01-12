class AddAgeIsPublicAndGenderIsPublicToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :age_is_public, :boolean, default: false
    add_column :users, :gender_is_public, :boolean, default: false
  end
end
