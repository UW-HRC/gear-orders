class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def verify_open
    active_sale = GearSale.active_sale
    if active_sale.nil? || !active_sale.open?
      flash[:warning] = 'Unfortunately, gear orders are closed.'
      redirect_to root_path
      false
    else
      true
    end
  end

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:warning] = "You don't have permission to do that."
      redirect_to root_path
    end
  end


  def admin_signed_in?
    helpers.admin_signed_in?
  end
end
