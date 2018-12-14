class AddUserToLoanItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :loan_items, :user
  end
end
