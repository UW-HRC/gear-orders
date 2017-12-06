class AddItemToPurchase < ActiveRecord::Migration[5.1]
  def change
    add_reference :purchases, :item, foreign_key: true
  end
end
