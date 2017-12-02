
class RemoveCustomers < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :customer_id
    drop_table :customers
  end
end
