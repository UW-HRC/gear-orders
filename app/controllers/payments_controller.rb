class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    set_order
    @payment = Payment.new(payment_params)
    @payment.order = @order

    respond_to do |f|
      if @payment.save
        f.html { redirect_to @order, notice: 'Payment was successfully created.' }
      else
        f.html { redirect_to @order, alert: 'Error adding payment: ' + @payment.errors.full_messages.join(', ') }
      end
    end
  end

  def destroy
    set_payment
    set_order
    @payment.destroy
    respond_to do |f|
      f.html { redirect_to @order, notice: 'Payment was successfully destroyed.' }
    end
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def set_order
      @order = Order.find(params[:order_id])
    end

    def payment_params
      params.require(:payment).permit(:amount, :method)
    end
end