class User < ApplicationRecord
  enum role: {
      default: 0,
      admin: 100
  }

  has_many :orders

  def display_name
    name = ""
    name << first_name unless first_name.blank?
    name << " #{last_name}" unless last_name.blank?

    name.blank? ? email : name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable,
         :saml_authenticatable
end
