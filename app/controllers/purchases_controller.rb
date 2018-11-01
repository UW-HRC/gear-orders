class PurchasesController < ApplicationController
  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    set_order
    set_purchase
    if @purchase.order.fulfilled?
      flash[:warning] = 'You cannot remove items on a fulfilled order.'
      redirect_to @order
    else
      @purchase.destroy
      respond_to do |f|
        f.html do
          flash[:success] = 'Item was successfully destroyed.'
          redirect_to @order
        end
      end
    end
  end

  private
  def set_order
    @order = Order.find(params[:order_id])
    if @order.confirmed?
      flash[:warning] = 'You cannot make changes to an order once it\'s finalized. Please let us know if you need to make a change.'
      redirect_to @order
    end
  end
end

# Use callbacks to share common setup or constraints between actions.
def set_purchase
  @purchase = Purchase.find(params[:id])
end

# Never trust parameters from the scary internet, only allow the white list through.
def purchase_params
  params.fetch(:purchase, {}).permit(:quantity, :size_id)
end
