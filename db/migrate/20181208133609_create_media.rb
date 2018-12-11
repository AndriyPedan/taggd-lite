class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :type
      t.string :media_url
      t.integer :status, default: 0
      t.string :created_time
      t.string :permalink
      t.string :like_count
      t.string :comments_count
      t.string :instagram_id
      t.string :thumbnail_url
      t.string :username
      t.string :caption

      t.timestamps
    end
  end
end
