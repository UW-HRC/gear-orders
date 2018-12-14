class LoanStatusUpdate < ApplicationRecord
  belongs_to :loan_item
  belongs_to :user, optional: true
  belongs_to :old_user, class_name: 'User', optional: true
  belongs_to :author, class_name:  'User'
end
