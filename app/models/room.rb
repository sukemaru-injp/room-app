class Room < ApplicationRecord
  belongs_to :user
  has_many :room_tag_relations
  has_many :tags, through: :room_tag_relations

  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :content
    validates :image
  end


  # ↓activehash関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :place
  belongs_to :floor
  belongs_to :style


  
  with_options numericality: { other_than: 1 }, presence: true do
    validates :place_id
    validates :floor_id
    validates :style_id

  end


end
