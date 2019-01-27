require 'csv'

class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @active_sale = GearSale.active_sale
    @inactive_sales = GearSale.where(active: false)
  end

  def users
    @users = User.order(:email)
  end

  def set_role
    @user = User.find(params[:id])
    if @user == current_user
      flash[:warning] = "You cannot change your own admin permissions."
    elsif @user.update role: params[:user][:role]
      flash[:success ] = "Admin permissions for #{@user.display_name} were updated."
    else
      flash[:warning] = "Error updating user role: #{@user.errors.full_messages.join(", ")}"
    end

    redirect_to admin_users_path
  end

  def sale_reports
    @active_sale = GearSale.active_sale
  end

  def generate_report
    only_finalized =  ActiveRecord::Type::Boolean.new.cast(params[:only_finalized])

    if params[:report_type] == 'item_sales'

      header_row = %w(Name Price)

      sizes = Size.order('id')

      sizes.each do |size|
        header_row << size.size
      end

      csv_arr = [header_row]

      GearSale.active_sale.items.order(:created_at).each do |item|
        row = [item.name, item.price]

        sizes.each do |size|
          if item.sizes.exists? size.id
            if only_finalized
              row << size.purchases.joins(:order).where('purchases.item_id = ? AND orders.confirmed = ?', item.id, true).count
            else
              row << size.purchases.where(item: item.id).count
            end
          else
            row << 0
          end
        end
        csv_arr << row
      end

      csv_str = CSV.generate do |csv|
        csv_arr.each do |ca|
          csv << ca
        end
      end

      render plain: csv_str
    else
      orders = only_finalized ?
                   GearSale.active_sale.orders.order(:created_at).where(confirmed: true) :
                   GearSale.active_sale.orders.order(:created_at)

      header_row = ['Finalized', 'Fulfilled', 'Name', 'Email', 'Total Amount', 'Total Paid']

      csv_str = CSV.generate do |csv|
        csv << header_row

        orders.each do |order|
          csv << [order.confirmed, order.fulfilled, order.user.display_name, order.user.email, order.total, order.amount_paid]
        end
      end

      render plain: csv_str
    end
  end
end
