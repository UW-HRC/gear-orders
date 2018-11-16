class OrdersController < ApplicationController
  before_action :authenticate_user!

  # only admins are allowed to view all orders, delete orders, and toggle fulfilled
  before_action :authenticate_admin!, only: [:index, :destroy, :toggle_fulfilled]
  before_action :verify_open, only: [:new, :create, :edit, :update, :new_purchase, :create_purchase]

  # GET /orders
  def index
    @orders = params[:only_final] ?
                  GearSale.active_sale.orders.order(:created_at).where(confirmed: true) :
                  GearSale.active_sale.orders.order(:created_at)
  end

  # GET /my_orders
  # This just shows the user's orders, as opposed to the admin path which shows all orders for the active sale
  def index_for_user
    # each user should only have one order per sale
    @orders = current_user.orders
    @current_order = @orders.where(gear_sale: GearSale.active_sale).first
    @past_orders = @orders.where.not(gear_sale: GearSale.active_sale)
  end

  # GET /orders/1
  def show
    set_order
  end

  # GET /orders/1/edit
  def edit
    set_order
  end

  # POST /orders
  def create
    @order = current_user.orders.new(order_params)
    @order.gear_sale = GearSale.active_sale

    if @order.save
      flash[:success] = 'Order was successfully created.'
      redirect_to @order
    else
      render :new
    end
  end

  # DELETE /orders/1
  def destroy
    set_order

    if @order.payments.size > 0
      flash[:warning] = 'Payment have been made on this order. Please remove them before removing the order.'
    else
      @order.destroy
      flash[:success] = 'Order was successfully destroyed.'
    end

    redirect_to orders_path
  end

  def toggle_fulfilled
    set_order

    if @order.confirmed? && @order.total - @order.amount_paid == 0
      @order.update_attributes fulfilled: !@order.fulfilled
      flash[:success] = 'Updated successfully.'
    else
      flash[:warning] = 'Order must be finalized and fully paid first.'
    end

    redirect_to orders_path
  end

  def toggle_finalized
    set_order

    target = params[:all] ? orders_path : @order

    unless admin_signed_in? || verify_open
      return
    end

    if @order.confirmed?
      authenticate_admin!
      if @order.fulfilled?
        flash[:warning] = 'You cannot un-finalize a fulfilled order.'
        redirect_to target
      else
        @order.update_attributes confirmed: false
        flash[:success] = 'Un-finalized successfully.'
        redirect_to target
      end
    else
      if @order.purchases.count == 0
        flash[:warning] = 'You cannot finalize an empty order. Please add some items first.'
        redirect_to target
        return
      end

      @order.update_attributes confirmed: true
      flash[:success] = 'Finalized successfully.'
      redirect_to target
    end
  end

  def new_purchase
    set_order
  end

  def create_purchase
    set_order

    item = Item.find(params[:item_id])
    if @order.gear_sale != item.gear_sale
      flash[:warning] = "Order and item must belong to the same gear sale."
    else
      @order.purchases.create! item_id: params[:item_id], size_id: params[:size_id]
      flash[:success] = 'Item was successfully added.'
    end

    redirect_to @order
  end

  def unfinished_order_mail
    @orders = Order.where confirmed: false

    @orders.each do |o|
      OrderMailer.unfinished_order(o).deliver_later
    end

    flash[:success] = "Successfully sent #{@orders.count} #{'email'.pluralize @orders.count}."
    redirect_to root_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    if admin_signed_in?
      # admins are allowed to access all orders
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.fetch(:order, {}).permit(:first_name, :last_name, :email)
  end
end
