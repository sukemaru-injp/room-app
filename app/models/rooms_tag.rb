class RoomsTag
  include ActiveModel::Model
  attr_accessor :image, :title, :content, :place_id, :floor_id, :style_id, :name, :user_id


  def save
    room = Room.create(image: image, title: title, content: content, place_id: place_id, floor_id: floor_id, style_id: style_id, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    RoomTagRelation.create(room_id: room.id, tag_id: tag.id)
  end
end