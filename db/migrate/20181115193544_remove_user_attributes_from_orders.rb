class RemoveUserAttributesFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :first_name, :string
    remove_column :orders, :last_name, :string
    remove_column :orders, :email, :string
  end
end
