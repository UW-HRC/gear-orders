class GearSalesAreActive < ActiveRecord::Migration[5.1]
  def change
    remove_column :gear_sales, :open_date, :date
    remove_column :gear_sales, :close_date, :date
    add_column :gear_sales, :active, :boolean, default: false
  end
end
