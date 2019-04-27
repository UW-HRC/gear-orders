class User < ApplicationRecord
  enum role: {
      default: 0,
      admin: 100
  }

  has_many :orders, dependent: :destroy
  has_many :loan_status_updates
  has_many :loan_items

  def display_name(use_preferred=true)
    if !preferred_name.blank? && use_preferred
      preferred_name
    elsif not full_name.blank?
      full_name
    else
      email
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable,
         :saml_authenticatable
end
