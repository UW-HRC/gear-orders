class AddDefaultAmountPaidToOrders < ActiveRecord::Migration[5.1]
  def change
    change_column_default :orders, :amount_paid, 0.00
  end
end
