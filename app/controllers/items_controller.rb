class ItemsController < ApplicationController
  before_action :authenticate_user!, :except [:indec, :show]
  before_action :item_find, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end
  private

  def item_params
    params.require(:item).permit(:image, :item_name, :information, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :schedule_id, :price).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def user_check
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
