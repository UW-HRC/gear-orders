class AddSizeToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_reference :purchases, :size, foreign_key: true
  end
end
