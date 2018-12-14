class StatusUpdateHasAuthor < ActiveRecord::Migration[5.1]
  def change
    add_reference :loan_status_updates, :author
    add_foreign_key :loan_status_updates, :users, column: :author_id

  end
end
