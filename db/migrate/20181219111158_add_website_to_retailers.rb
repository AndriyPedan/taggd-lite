class AddWebsiteToRetailers < ActiveRecord::Migration[5.2]
  def change
    add_column :retailers, :website, :string
  end
end
