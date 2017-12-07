class Size < ApplicationRecord
  has_and_belongs_to_many :items
  has_many :purchases

  validates_uniqueness_of :size
end
