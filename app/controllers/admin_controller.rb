class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @active_sale = GearSale.active_sale
    @inactive_sales = GearSale.where(active: false)
  end
end
