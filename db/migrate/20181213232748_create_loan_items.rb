class CreateLoanItems < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_items do |t|
      t.string :name
      t.integer :inventory_number

      t.timestamps
    end
  end
end
