class DeleteVideoCategory < ActiveRecord::Migration[7.0]
  def change
    drop_table :video_categories
  end
end
