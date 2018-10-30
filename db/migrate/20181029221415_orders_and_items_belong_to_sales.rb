class OrdersAndItemsBelongToSales < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :gear_sale, foreign_key: true
    add_reference :items, :gear_sale, foreign_key: true
  end
end
