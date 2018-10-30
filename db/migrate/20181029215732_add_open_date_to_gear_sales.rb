class AddOpenDateToGearSales < ActiveRecord::Migration[5.1]
  def change
    add_column :gear_sales, :open_date, :date
  end
end
