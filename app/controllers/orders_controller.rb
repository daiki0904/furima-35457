class OrdersController < ApplicationController
  before_action :authenticate_user!,:item_find

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building, :phone).merge(user_id: current_user.id, item_id: @item.id)
  end

  def item_find
    @item = Item.includes(:order).find(params[:item_id])
  end
end
