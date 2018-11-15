class Order < ApplicationRecord
  belongs_to :gear_sale
  belongs_to :user

  has_many :purchases, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :payments, -> { order(created_at: :asc) }, dependent: :destroy

  # Users should only have one order per gear sale
  validates :gear_sale, uniqueness: { scope: :user }

  def amount_paid
    self.payments.reduce(0) { |acc, p| acc + p.amount }
  end

  def total
    self.purchases.select{|p| p.item.sizes.include?(p.size)}.reduce(0) do |acc, p|
      acc + (p.item.price)
    end
  end
end
