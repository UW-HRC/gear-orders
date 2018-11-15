class StaticPagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_orders_path
    end
  end
end
