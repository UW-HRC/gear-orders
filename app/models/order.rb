class Order < ApplicationRecord
  has_many :purchases
  has_many :item_sizes, through: :purchases

  before_create :randomize_id

  validates_presence_of :first_name, :last_name, :email

  private
    # give orders random IDs to make them harder to guess
    def randomize_id
      begin
        self.id = SecureRandom.random_number(1_000_000)
      end while Order.where(id: self.id).exists?
    end
end
