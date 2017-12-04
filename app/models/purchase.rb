class Purchase < ApplicationRecord
  belongs_to :item_size
  belongs_to :order

  validates_presence_of :quantity

  validate :sufficient_quantity

  private
    # can't buy more than are available!!
    def sufficient_quantity
      if self.item_size && self.quantity > self.item_size.quantity_available
        errors.add(:quantity, 'must be less than or equal to quantity available.')
      end
    end
end
