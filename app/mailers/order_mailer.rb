class OrderMailer < ApplicationMailer
  def order_created(order)
    @order = order
    mail to: @order.email, subject: 'New HRC Gear Order', from: 'Husky Running Club <huskyrunningclub@gmail.com>'
  end
end
