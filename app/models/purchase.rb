class Purchase < ApplicationRecord
  belongs_to :size
  belongs_to :item
  belongs_to :order
end
