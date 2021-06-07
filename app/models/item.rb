class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
  has_many_attached :images
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :schedule
  belongs_to :shipping_fee
  belongs_to :status
end
