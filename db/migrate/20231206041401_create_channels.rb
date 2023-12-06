class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :channel_id,         null: false, index: { unique: true }
      t.string :thumbnail_url
      t.string :name,               null:false
      t.integer :subscriber_count,  null: false
      t.text :description

      t.timestamps
    end
  end
end
