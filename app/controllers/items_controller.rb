class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /items
  def index
    @items = GearSale.active_sale.items.order(:created_at)
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    @item.gear_sale = GearSale.active_sale

    if @item.save
      flash[:success] = 'Item was successfully created.'
      redirect_to @item
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      flash[:success] = 'Item was successfully updated.'
      redirect_to @item
    else
      render :edit
    end
  end
end

# DELETE /items/1
def destroy
  @item.destroy
  flash[:success] = 'Item was successfully destroyed.'
  redirect_to items_path
end

private
# Use callbacks to share common setup or constraints between actions.
def set_item
  @item = Item.find(params[:id])
end

# Never trust parameters from the scary internet, only allow the white list through.
def item_params
  params.fetch(:item, {}).permit(:name, :description, :photo, :price, size_ids: [])
end
