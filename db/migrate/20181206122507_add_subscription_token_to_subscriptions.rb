class AddSubscriptionTokenToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :subscription_token, :string
  end
end
