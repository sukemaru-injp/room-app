class Tag < ApplicationRecord
  has_many :room_tag_relations, dependent: :destroy
  has_many :rooms, through: :room_tag_relations, dependent: :destroy
end
