class AddFieldsToMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :media_type, :string
    add_reference :media, :retailer, foreign_key: true
  end
end
