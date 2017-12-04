class Payment < ApplicationRecord
  belongs_to :order
  validates_presence_of :method, :amount

  validate :validate_amount

  def validate_amount
    return unless self.amount

    # if self.amount < 0
    #   self.errors.add(:amount, 'must be greater than 0')
    if self.amount > self.order.total - self.order.amount_paid
      self.errors.add(:amount, 'must be less than amount due')
    end
  end
end
