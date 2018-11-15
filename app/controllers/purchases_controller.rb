class PurchasesController < ApplicationController
  before_action :authenticate_user!

  # DELETE /purchases/1
  def destroy
    set_order
    set_purchase
    if @purchase.order.fulfilled?
      flash[:warning] = 'You cannot remove items on a fulfilled order.'
    else
      @purchase.destroy
      flash[:success] = 'Item was successfully destroyed.'
    end

    redirect_to @order
  end

  private
  def set_order
    @order = current_user.orders.find(params[:order_id])
    if @order.confirmed?
      flash[:warning] = 'You cannot make changes to an order once it\'s finalized. Please let us know if you need to make a change.'
      redirect_to @order
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
end

