class RoomsTag
  include ActiveModel::Model
  attr_accessor :image, :title, :content, :place_id, :floor_id, :style_id, :name, :user_id

  with_options presence: true do
    validates :title
    validates :content
    validates :image
  end

  # activehash関連↓
  with_options numericality: { other_than: 1 }, presence: true do
    validates :place_id
    validates :floor_id
    validates :style_id
  end


  def save
    room = Room.create(image: image, title: title, content: content, place_id: place_id, floor_id: floor_id, style_id: style_id, user_id: user_id)
    
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    RoomTagRelation.create(room_id: room.id, tag_id: tag.id)
  end
end