class AddFrozenToGearSale < ActiveRecord::Migration[5.1]
  def change
    add_column :gear_sales, :open, :boolean, default: false
  end
end
