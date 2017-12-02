class CreateItemSizes < ActiveRecord::Migration[5.1]
  def change
    create_table :item_sizes do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.boolean :has_quantity
      t.timestamps
    end
  end
end
