class CreateRetailers < ActiveRecord::Migration[5.2]
  def change
    create_table :retailers do |t|
      t.string :username
      t.string :name
      t.string :business_id
      t.string :token
      
      t.references :user

      t.timestamps null: false
    end
  end
end
