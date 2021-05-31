class OrdersController < ApplicationController
  before_action :authenticate_user!,:item_find,:user_check

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building, :phone).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def item_find
    @item = Item.includes(:order).find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: order_params[:token],  
      currency: 'jpy'             
    )
  end

  def user_check
    unless @item.order.blank? && current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
