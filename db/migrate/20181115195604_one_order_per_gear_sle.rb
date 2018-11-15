class OneOrderPerGearSle < ActiveRecord::Migration[5.1]
  def change
    add_index :orders, [:gear_sale_id, :user_id], unique: true
  end
end
