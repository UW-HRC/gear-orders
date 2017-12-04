class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.decimal :amount
      t.string :method

      t.timestamps
    end
  end
end
