module ApplicationHelper
  def sum_item_size_purchases(size)
    size.purchases.reduce(0) do |n, purchase|
      n + purchase.quantity
    end
  end
end
