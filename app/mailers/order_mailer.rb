class OrderMailer < ApplicationMailer
  def order_created(order)
    @order = order
    mail to: @order.email, subject: 'New HRC Gear Order'
  end
end
