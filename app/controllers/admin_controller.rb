class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @active_sale = GearSale.active_sale
    @inactive_sales = GearSale.where(active: false)
  end

  def users
    @users = User.order(:email)
  end

  def set_role
    @user = User.find(params[:id])
    if @user == current_user
      flash[:warning] = "You cannot change your own admin permissions."
    elsif @user.update role: params[:user][:role]
      flash[:success ] = "Admin permissions for #{@user.display_name} were updated."
    else
      flash[:warning] = "Error updating user role: #{@user.errors.full_messages.join(", ")}"
    end

    redirect_to admin_users_path
  end
end
