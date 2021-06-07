class ItemsTag

  include ActiveModel::Model
  attr_accessor :item_name, :information, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :schedule_id, :price, :user_id, :name, :image

  with_options presence: true do
    validates :item_name
    validates :information
    validates :price, format: { with: /\A[0-9]+\z/ },
                      numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :name
    validates :user_id
    validates :image
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :schedule_id
  end

  def save
    item = Item.create( item_name: item_name, information: information, category_id: category_id, status_id: status_id, shipping_fee_id: shipping_fee_id, prefecture_id: prefecture_id, schedule_id: schedule_id, price: price, user_id: user_id, image: image)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end
end