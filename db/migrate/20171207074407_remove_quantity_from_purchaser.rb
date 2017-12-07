class RemoveQuantityFromPurchaser < ActiveRecord::Migration[5.1]
  def change
    remove_column :purchases, :quantity
  end
end
