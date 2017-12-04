class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy, :update_quantity]
  before_action :get_items, only: [:new, :create, :edit, :update]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    set_order
    @purchase = @order.purchases.build
  end

  # GET /purchases/1/edit
  # def edit
  #   set_order
  # end

  # POST /purchases
  # POST /purchases.json
  def create
    set_order
    @purchase = Purchase.new(purchase_params)
    @purchase.order = @order

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @order, notice: 'Purchase was successfully created.' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  # def update
  #   set_order
  #   respond_to do |format|
  #     if @purchase.update(purchase_params)
  #       format.html { redirect_to @order, notice: 'Purchase was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @purchase }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @purchase.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    set_order
    if @purchase.order.fulfilled?
      redirect_to @order, alert: 'You cannot remove items on a fulfilled order.'
    else
      @purchase.destroy
      respond_to do |f|
        f.html { redirect_to @order, notice: 'Item was successfully destroyed.' }
      end
    end
  end

  private
    def set_order
      @order = Order.find(params[:order_id])
      if @order.confirmed?
        respond_to do |format|
          format.html { redirect_to @order, notice: 'You cannot make changes to an order once it\'s finalized. Please let us know if you need to make a change.' }
          format.json { render :show, status: 400, location: @order }
        end
      end
    end

    def get_items
      @items = Item.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.fetch(:purchase, {}).permit(:quantity, :item_size_id)
    end
end
