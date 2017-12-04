class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.decimal :amount_paid, precision: 10, scale: 2

      t.timestamps
    end
  end
end
