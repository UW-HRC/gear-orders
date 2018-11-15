class OrderMailer < ApplicationMailer
  def order_created(order)
    @order = order
    mail to: @order.email, subject: 'New HRC Gear Order', from: 'Husky Running Club <uwrunner@uw.edu>'
  end

  def unfinished_order(order)
    @order = order
    mail to: @order.email, subject: 'Unfinished HRC Gear Order', from: 'Husky Running Club <uwrunner@uw.edu>'
  end
end
