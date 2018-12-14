class AddOldUserToStatusUpdate < ActiveRecord::Migration[5.1]
  def change
    add_reference :loan_status_updates, :old_user
    add_foreign_key :loan_status_updates, :users, column: :old_user_id
  end
end
