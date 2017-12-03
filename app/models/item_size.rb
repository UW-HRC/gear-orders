class ItemSize < ApplicationRecord
  belongs_to :item

  has_many :purchases
  has_many :orders, through: :purchases

  validates_presence_of :name, :price, :quantity

  def quantity_available
    purchased = self.purchases.all.reduce(0) do |acc, p|
      acc + p.quantity
    end

    self.quantity - purchased
  end
end
