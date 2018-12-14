class LoanItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @loan_items = LoanItem.all
  end

  def show
    @loan_item = LoanItem.find(params[:id])
  end

  def edit
    @loan_item = LoanItem.find(params[:id])
  end

  def create
    @loan_item = LoanItem.new loan_item_params
    if @loan_item.save
      flash[:success] = "Loan item was created."
      redirect_to @loan_item
    else
      render 'new'
    end
  end

  def new
    @loan_item = LoanItem.new
  end

  def update
    @loan_item = LoanItem.find(params[:id])
    if @loan_item.update loan_item_params
      flash[:success] = "Loan item was updated."
      redirect_to @loan_item
    else
      render 'edit'
    end
  end

  def update_status
    @loan_item = LoanItem.find(params[:id])
    @update = @loan_item.loan_status_updates.new status_params
    @update.old_user_id = @loan_item.user_id
    @update.author = current_user

    # this must be done atomically to ensure that the update matches
    # who the item is actually checked out to
    ActiveRecord::Base.transaction do
      @update.save!
      @loan_item.update! user: @update.user
    end

    flash[:success] = "Loan item was updated."
    redirect_to @loan_item
  end

  private
  def status_params
    params.require(:loan_status_update).permit(:user_id, :notes)
  end

  def loan_item_params
    params.require(:loan_item).permit(:name, :inventory_number)
  end
end
