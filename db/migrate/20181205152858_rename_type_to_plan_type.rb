class RenameTypeToPlanType < ActiveRecord::Migration[5.2]
  def change
    rename_column :subscriptions, :type, :plan_type
  end
end
