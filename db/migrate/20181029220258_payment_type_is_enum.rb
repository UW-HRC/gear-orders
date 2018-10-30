class PaymentTypeIsEnum < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :method, :string
    add_column :payments, :method, :integer
  end
end
