class ItemsController < ApplicationController
  def index
  end

  private
  
  def item_params
    params.require(:item).permit(:image,:item_name,:information,:category_id,:status_id,:shipping_fee_id,:prefecture_id,:schedule_id,:price).merge(user_id: current_user.id)
  end
end
