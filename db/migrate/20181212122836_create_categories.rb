class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.references :parent
      t.references :retailer
      t.string :name

      t.timestamps null: false
    end
  end
end
