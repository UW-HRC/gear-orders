class ItemSizesController < ApplicationController
  before_action :set_item_size, only: [:show, :edit, :update, :destroy]

  # GET /item_sizes
  # GET /item_sizes.json
  def index
    @item_sizes = ItemSize.all
  end

  # GET /item_sizes/1
  # GET /item_sizes/1.json
  def show
  end

  # GET /item_sizes/new
  def new
    @item = Item.find(params[:item_id])
    @item_size = @item.item_sizes.build
  end

  # GET /item_sizes/1/edit
  def edit
  end

  # POST /item_sizes
  # POST /item_sizes.json
  def create
    @item = Item.find(params[:item_id])
    @item_size = ItemSize.new(item_size_params)
    @item_size.item = @item

    respond_to do |format|
      if @item_size.save
        format.html { redirect_to @item, notice: 'Item size was successfully created.' }
        format.json { render :show, status: :created, location: @item_size }
      else
        format.html { render :new }
        format.json { render json: @item_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_sizes/1
  # PATCH/PUT /item_sizes/1.json
  def update
    @item = Item.find(params[:item_id])

    respond_to do |format|
      if @item_size.update(item_size_params)
        format.html { redirect_to @item, notice: 'Item size was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_size }
      else
        format.html { render :edit }
        format.json { render json: @item_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_sizes/1
  # DELETE /item_sizes/1.json
  def destroy
    @item_size.destroy
    respond_to do |format|
      format.html { redirect_to item_path, notice: 'Item size was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_size
      @item_size = ItemSize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_size_params
      params.fetch(:item_size, {}).permit(:name, :price, :quantity, :has_quantity)
    end
end
