class Room < ApplicationRecord
  belongs_to :user
  has_many :room_tag_relations
  has_many :tags, through: :room_tag_relations

  has_one_attached :image
end
