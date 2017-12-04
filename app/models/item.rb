class Item < ApplicationRecord
  has_many :item_sizes, dependent: :destroy
  validates_presence_of :name
end
