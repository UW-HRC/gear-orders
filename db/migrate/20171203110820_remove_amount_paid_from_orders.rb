class RemoveAmountPaidFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :amount_paid
  end
end
