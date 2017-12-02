class ItemSize < ApplicationRecord
  belongs_to :item

  has_many :purchases
  has_many :orders, through: :purchases

  validates_presence_of :name, :price, :quantity, :has_quantity
end
