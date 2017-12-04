class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :unfinalize, :destroy, :toggle_fulfilled]

  # GET /orders
  # GET /orders.json
  def index
    @orders = params[:only_final] ? Order.where(confirmed: true) : Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
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

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
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
    respond_to do |format|
      if @order.confirmed? && !user_signed_in?
        format.html { redirect_to @order, notice: 'You cannot make changes to an order once it\'s finalized. Please let us know if you need to make a change.' }
        format.json { render :show, status: 400, location: @order }
        return
      end

      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
   if @order.payments.size > 0
     respond_to do |format|
       format.html { redirect_to orders_url, alert: 'Payment have been made on this order. Please remove them before removing the order.' }
       format.json { head :no_content }
     end
     return
   end

    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_fulfilled
    set_order

    if @order.confirmed? && @order.total - @order.amount_paid == 0
      @order.update_attributes fulfilled: !@order.fulfilled
      redirect_to orders_path, notice: 'Updated successfully.'
    else
      redirect_to orders_path, alert: 'Order must be finalized and fully paid first.'
    end
  end

  def finalize
    set_order
    @order.update_attributes confirmed: true
    redirect_to @order, notice: 'Finalized successfully.'
  end

  def unfinalize
    set_order

    if @order.fulfilled?
      redirect_to @order, alert: 'You cannot un-finalize a fulfilled order.'
    else
      @order.update_attributes confirmed: false
      redirect_to @order, notice: 'Unfinalized successfully.'

    end
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
