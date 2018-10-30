class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    set_order
    @payment = Payment.new(payment_params)
    @payment.order = @order

    respond_to do |f|
      if @payment.save
        f.html do
          flash[:success] = 'Payment was successfully created.'
          redirect_to @order
        end
      else
        f.html do
          flash[:warning] = 'Error adding payment: ' + @payment.errors.full_messages.join(', ')
          redirect_to @order
        end
      end
    end
  end

  def destroy
    set_payment
    set_order

    if @payment.order.fulfilled?
      flash[:warning] = 'You cannot remove payments on a fulfilled order.'
      redirect_to @order
    else
      @payment.destroy
      respond_to do |f|
        f.html do
          flash[:success] = 'Payment was successfully destroyed.'
          redirect_to @order
        end
      end
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