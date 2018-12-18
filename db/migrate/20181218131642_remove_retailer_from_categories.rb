class RemoveRetailerFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_reference :categories, :retailer
  end
end
