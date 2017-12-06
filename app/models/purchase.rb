class Purchase < ApplicationRecord
  belongs_to :size
  belongs_to :item
  belongs_to :order

  validates_presence_of :quantity

end
