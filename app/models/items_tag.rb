class ItemsTag

  include ActiveModel::Model
  attr_accessor :item_id, :name

  with_options presence: true do
    validates :name
    validates :item_id
  end

  def save
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item_id, tag_id: tag.id)
  end
end