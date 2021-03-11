class RoomTagRelation < ApplicationRecord
  belongs_to :room
  belongs_to :tag
end
