class PaymentsController < ApplicationController
  before_action :authenticate_admin!

  def create
    set_order
    @payment = Payment.new(payment_params)
    @payment.order = @order

    if @order.fulfilled?
      flash[:warning] = 'You cannot add payments to a fulfilled order.'
    elsif @payment.save
      flash[:success] = 'Payment was successfully created.'
    else
      flash[:warning] = 'Error adding payment: ' + @payment.errors.full_messages.join(', ')
    end

    redirect_to @order
  end

  def destroy
    set_payment
    set_order

    if @payment.order.fulfilled?
      flash[:warning] = 'You cannot remove payments on a fulfilled order.'
    else
      @payment.destroy
      flash[:success] = 'Payment was successfully destroyed.'
    end

    redirect_to @order
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