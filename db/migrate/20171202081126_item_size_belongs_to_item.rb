class ItemSizeBelongsToItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :item_sizes, :item, index: true
  end
end
