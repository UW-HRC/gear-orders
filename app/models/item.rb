class Item < ApplicationRecord
  has_many :item_sizes
  validates_presence_of :name
end
