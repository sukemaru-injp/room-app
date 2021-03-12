class Room < ApplicationRecord
  belongs_to :user
  has_many :room_tag_relations
  has_many :tags, through: :room_tag_relations

  has_one_attached :image



  # ↓activehash関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :place
  belongs_to :floor
  belongs_to :style


end
