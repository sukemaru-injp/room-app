class RoomsTag
  include ActiveModel::Model
  attr_accessor :image, :title, :content, :place_id, :floor_id, :style_id, :name, :user_id

  with_options presence: true do
    validates :title, length: { maximum: 20 }
    validates :content
    validates :image
    validates :user_id
  end

  # activehash関連↓
  with_options numericality: { other_than: 1 }, presence: true do
    validates :place_id
    validates :floor_id
    validates :style_id
  end

  delegate :persisted?, to: :room
  
  def initialize(attributes = nil, room: Room.new)
    @room = room
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list)

    ActiveRecord::Base.transaction do
      @room.update(image: image, title: title, content: content, place_id: place_id, floor_id: floor_id, style_id: style_id, user_id: user_id)
      @room.room_tag_relations.each do |tag|
        tag.delete
      end

      tag_list.each do |tag_name|
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save

        room_tag = RoomTagRelation.where(room_id: @room.id, tag_id: tag.id).first_or_initialize
        room_tag.update(room_id: @room.id, tag_id: tag.id)
      end
    end
  
  end

  def to_model
    room
  end

  private
  attr_reader :room

  def default_attributes
    {
      image: room.image,
      title: room.title,
      content: room.content,
      place_id: room.place_id,
      floor_id: room.floor_id,
      style_id: room.style_id,
      name: room.tags.pluck(:name).join(',')
    }
  end

end