class User < ApplicationRecord
  enum role: {
      default: 0,
      admin: 100
  }

  has_many :orders, dependent: :destroy

  def display_name
    full_name.blank? ? email : full_name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable,
         :saml_authenticatable
end
