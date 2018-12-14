class User < ApplicationRecord
  enum role: {
      default: 0,
      admin: 100
  }

  has_many :orders, dependent: :destroy
  has_many :loan_status_updates
  has_many :loan_items

  def display_name
    full_name.blank? ? email : full_name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable,
         :saml_authenticatable
end
