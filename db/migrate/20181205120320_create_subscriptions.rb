class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :retailer, index: { unique: true }
      t.string :plan_token, null: false
      t.string :card_token
      t.string :customer_token
      t.integer :type
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
