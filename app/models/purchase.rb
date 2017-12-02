class Purchase < ApplicationRecord
  belongs_to :item_size
  belongs_to :order

  validates_presence_of :quantity
end
