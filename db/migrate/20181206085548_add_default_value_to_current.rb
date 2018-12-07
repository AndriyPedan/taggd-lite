class AddDefaultValueToCurrent < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :retailers, :current, :boolean, default: true
    end

    def down
      change_column :retailers, :current, :boolean, default: nil
    end
  end
end
