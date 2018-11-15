class GearSale < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validate :there_can_only_be_one, :close_before_deactivating
  validates_presence_of :name

  def there_can_only_be_one
    if active?
      unless GearSale.where(active: true).where.not(id: id).empty?
        errors.add(:base, "Only one gear sale can be active at a time")
      end
    end
  end

  def close_before_deactivating
    if !active? && open?
      errors.add(:base, "Gear sale must be closed before it can be deactivated.")
    end
  end

  def self.active_sale
    GearSale.where(active: true).first
  end
end
