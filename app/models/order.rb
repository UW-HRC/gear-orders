class Order < ApplicationRecord
  has_many :purchases, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :payments, -> { order(created_at: :asc) }, dependent: :destroy

  before_create :randomize_id
  before_validation :strip_whitespace

  validates_presence_of :first_name, :last_name

  validates :email, presence: true, uniqueness: { case_sensitive: false, message: 'is already associated with an order. Please check your email for the link to access it, or contact Husky Running Club if you can\'t find it.'}

  def amount_paid
    self.payments.reduce(0) { |acc, p| acc + p.amount }
  end

  def total
    self.purchases.reduce(0) do |acc, p|
      acc + (p.item.price)
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private
    # give orders random IDs to make them harder to guess
    def randomize_id
      begin
        self.id = SecureRandom.random_number(1_000_000)
      end while Order.where(id: self.id).exists?
    end

    def strip_whitespace
      # trim whitespace from beginning and end of string attributes
      attribute_names.each do |name|
        if send(name).respond_to?(:strip)
          send("#{name}=", send(name).strip)
        end
      end
    end
end
