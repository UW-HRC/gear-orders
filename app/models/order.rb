class Order < ApplicationRecord
  has_many :purchases

  has_many :item_sizes, through: :purchases

  validates_presence_of :first_name, :last_name, :email
end
