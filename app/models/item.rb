class Item < ApplicationRecord
  has_and_belongs_to_many :sizes
  has_many :purchases, dependent: :destroy

  validates_presence_of :name, :price

  mount_uploader :photo, ItemPhotoUploader
end
