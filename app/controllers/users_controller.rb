class UsersController < ApplicationController
  def index
    # each user should only have one order per sale
    @orders = current_user.orders
    @current_order = @orders.where(gear_sale: GearSale.active_sale).first
    @past_orders = @orders.where.not(gear_sale: GearSale.active_sale)
    @active_sale = GearSale.active_sale
  end
end