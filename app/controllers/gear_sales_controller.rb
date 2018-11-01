class GearSalesController < ApplicationController
  before_action :authenticate_user!

  def new
    @gear_sale = GearSale.new
  end

  def create
    @gear_sale = GearSale.new gear_sale_params
    if @gear_sale.save
      flash[:success] = "Gear sale was created."
      redirect_to admin_index_path
    else
      render 'gear_sales/new'
    end
  end

  def edit
    set_gear_sale
  end

  def update
    set_gear_sale
    if @gear_sale.update gear_sale_params
      flash[:success] = "Gear sale was updated."
      redirect_to admin_index_path
    else
      render 'gear_sales/edit'
    end
  end

  def destroy
    set_gear_sale
    @gear_sale.destroy
    flash[:success] = "Gear sale was destroyed."
    redirect_to admin_index_path
  end

  def toggle_active
    set_gear_sale
    @gear_sale.update active: !@gear_sale.active
    flash[:success] = "Gear sale was updated."
    redirect_to admin_index_path
  end

  def toggle_open
    set_gear_sale
    @gear_sale.update open: !@gear_sale.open
    flash[:success] = "Gear sale was updated."
    redirect_to admin_index_path
  end

  private
  def gear_sale_params
    params.require(:gear_sale).permit(:name, :active, :status)
  end

  def set_gear_sale
    @gear_sale = GearSale.find(params[:id])
  end
end
