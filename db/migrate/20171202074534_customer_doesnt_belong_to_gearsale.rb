
class CustomerDoesntBelongToGearsale < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :gear_sale_id
    remove_column :items, :gear_sale_id
  end
end
