class AddCurrentToRetailers < ActiveRecord::Migration[5.2]
  def change
    add_column :retailers, :current, :boolean
  end
end
