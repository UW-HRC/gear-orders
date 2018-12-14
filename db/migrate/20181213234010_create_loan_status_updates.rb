class CreateLoanStatusUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_status_updates do |t|
      t.references :loan_item, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status
      t.text :notes

      t.timestamps
    end
  end
end
