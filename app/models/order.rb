class Order < ApplicationRecord
  has_many :purchases
  has_many :payments
  has_many :item_sizes, through: :purchases

  before_create :randomize_id

  validates_presence_of :first_name, :last_name, :email

  def amount_paid
    self.payments.reduce(0) { |acc, p| acc + p.amount }
  end

  def total
    self.purchases.reduce(0) do |acc, p|
      acc + (p.item_size.price * p.quantity)
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private
    # give orders random IDs to make them harder to guess
    def randomize_id
      begin
        self.id = SecureRandom.random_number(1_000_000)
      end while Order.where(id: self.id).exists?
    end
end
