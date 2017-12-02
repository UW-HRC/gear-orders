class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :gear_sale, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
