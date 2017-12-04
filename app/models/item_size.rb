class ItemSize < ApplicationRecord
  belongs_to :item

  has_many :purchases, dependent: :destroy
  has_many :orders, through: :purchases

  validates_presence_of :name, :price, :quantity
  validate :validate_quantity

  def quantity_purchased
    self.purchases.all.reduce(0) do |acc, p|
      acc + p.quantity
    end
  end

  def quantity_available
    quantity - quantity_purchased
  end

  def validate_quantity
    if quantity < 0
      errors.add(:quantity, 'must be at least 0')
    end

    if quantity_purchased > quantity
      errors.add(:quantity, "must be at least quantity purchased (#{quantity_purchased})")
    end
  end
end
