class Size < ApplicationRecord
  has_and_belongs_to_many :items

  validates_uniqueness_of :size
end
