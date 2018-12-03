class AddOmniauthToRetailer < ActiveRecord::Migration[5.2]
  def change
    add_column :retailers, :provider, :string
    add_column :retailers, :uid, :string
  end
end
