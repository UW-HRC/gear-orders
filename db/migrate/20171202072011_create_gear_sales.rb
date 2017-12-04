class CreateGearSales < ActiveRecord::Migration[5.1]
  def change
    create_table :gear_sales do |t|
      t.string :name
      t.date :close_date

      t.timestamps
    end
  end
end
