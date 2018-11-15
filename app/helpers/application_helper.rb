module ApplicationHelper
  def sum_item_size_purchases(size)
    size.purchases.reduce(0) do |n, purchase|
      n + purchase.quantity
    end
  end

  def admin_signed_in?
    current_user.admin?
  end
end
