class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_find, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]
  before_action :retrieve_item, except: [:destroy]
  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
    @itemtag = ItemsTag.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid? 
      @item.save
      @itemtag = ItemsTag.new(tag_params)
      if @itemtag.valid?
        @itemtag.save
        redirect_to root_path
      else
        render :new
      end
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

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def retrieve
    @items = Item.order(created_at: :desc)
  end

  def result
    @results = @p.result
  end

  def hashtag
    @tag = Tag.find(params[:id])
    @items = @tag.items
  end

  def tagcheck
    @tags = Tag.all
  end

  def checkresult
    unless params[:name].present? || params[:name] == nil
      redirect_to tagcheck_items_path
    else
      @tag = Tag.find_by(name: params[:name])
      if @tag == nil
        redirect_to tagcheck_items_path
      else
        @items = @tag.items
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :information, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :schedule_id, :price, images:[]).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def tag_params
    params.require(:item).permit(:name).merge(item_id: @item.id)
  end

  def user_check
    if @item.order.present? || current_user.id != @item.user_id
      redirect_to root_path
    end
  end

  def retrieve_item
    @p = Item.ransack(params[:q])
  end
end
