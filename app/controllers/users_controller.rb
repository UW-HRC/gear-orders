class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # each user should only have one order per sale
    @orders = current_user.orders
    @current_order = @orders.where(gear_sale: GearSale.active_sale).first
    @past_orders = @orders.where.not(gear_sale: GearSale.active_sale)
    @active_sale = GearSale.active_sale
  end

  def edit
  end

  def update
    if current_user.update user_params
      redirect_to user_index_path
    else
      render 'users/edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:preferred_name)
  end
end