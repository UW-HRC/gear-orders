class AddStatusToGearSale < ActiveRecord::Migration[5.1]
  def change
    add_column :gear_sales, :status, :text, default: ""
  end
end
