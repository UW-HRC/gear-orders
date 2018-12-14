class LoanItem < ApplicationRecord
  belongs_to :user, optional: true
  has_many :loan_status_updates

  validates_presence_of :name
end
