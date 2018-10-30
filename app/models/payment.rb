class Payment < ApplicationRecord
  belongs_to :order
  validates_presence_of :method, :amount
  enum method: {
      cash: 0,
      venmo: 1,
      refund: 2
  }

  validate :validate_amount

  def validate_amount
    return unless self.amount

    if self.amount < 0 && !refund?
      self.errors.add(:amount, 'must be greater than 0')
    elsif self.amount > 0 && refund?
      self.errors.add(:amount, 'must be less than 0')
    end
  end
end
