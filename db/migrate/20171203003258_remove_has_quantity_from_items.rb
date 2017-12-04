class RemoveHasQuantityFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :item_sizes, :has_quantity
  end
end
