class RenameRatailersToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :retailers, :users
  end
end
