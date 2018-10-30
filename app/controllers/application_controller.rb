class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def verify_open
    active_sale = GearSale.active_sale
    if active_sale.nil? || !active_sale.open?
      flash[:warning] = 'Unfortunately, gear orders are closed.'
      redirect_to root_path
    end
  end
end
