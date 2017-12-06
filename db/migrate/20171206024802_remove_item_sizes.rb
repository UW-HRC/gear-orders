class RemoveItemSizes < ActiveRecord::Migration[5.1]
  def change
    remove_column :purchases, :item_size_id
    drop_table :item_sizes

    add_column :items, :price, :decimal, precision: 10, scale: 2
  end
end
