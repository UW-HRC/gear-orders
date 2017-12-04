class PurchaseBelongsToItemSizeAndOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :purchases, :item_size, index: true
    add_reference :purchases, :order, index: true
  end
end
