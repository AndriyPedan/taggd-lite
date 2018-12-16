class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.belongs_to :media
      t.string :external_id
      t.text :canonical_url
      t.text :provider_url
      t.text :image_url
      t.decimal :price, precision: 8, scale: 2
      t.decimal :original_price, precision: 8, scale: 2
      t.string :currency
      t.string :description
      t.integer :gender
      t.string :brand
      t.string :availability
      t.string :name

      t.timestamps null: false
    end
  end
end
