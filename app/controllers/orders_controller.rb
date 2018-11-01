class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy, :new_purchase, :create_purchase]
  before_action :authenticate_user!, only: [:index, :destroy, :toggle_fulfilled]
  before_action :verify_open, only: [:new, :create, :edit, :update, :new_purchase, :create_purchase]

  # GET /orders
  # GET /orders.json
  def index
    @orders = params[:only_final] ?
                  GearSale.active_sale.orders.order(:created_at).where(confirmed: true) :
                  GearSale.active_sale.orders.order(:created_at)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.includes(:purchases, :payments).find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.gear_sale = GearSale.active_sale

    respond_to do |format|
      if @order.save
        OrderMailer.order_created(@order).deliver_later

        format.html do
          flash[:success] = 'Order was successfully created.'
          redirect_to @order
        end
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @order.confirmed? && !user_signed_in?
      flash[:warning] = 'You cannot make changes to an order once it\'s finalized. Please let us know if you need to make a change.'
      redirect_to @order
    elsif @order.update(order_params)
      flash[:success] = 'Order was successfully updated.'
      redirect_to @order
    else
      render :edit
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
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

    unless user_signed_in? || verify_open
      return
    end

    if @order.confirmed?
      authenticate_user!
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
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.fetch(:order, {}).permit(:first_name, :last_name, :email)
  end
end
