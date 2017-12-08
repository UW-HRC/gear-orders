# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def order_created
    OrderMailer.order_created(Order.last)
  end
end
