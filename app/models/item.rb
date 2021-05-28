class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :schedule
  belongs_to :shipping_fee
  belongs_to :status

  with_options presence: true do
    validates :image
    validates :item_name
    validates :information
    validates :price, format: { with: /\A[0-9]+\z/ },
                      numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :schedule_id
  end
end
