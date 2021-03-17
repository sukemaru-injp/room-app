class Room < ApplicationRecord
  belongs_to :user
  has_many :room_tag_relations, dependent: :destroy
  has_many :tags, through: :room_tag_relations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  has_one_attached :image

  def self.search(search)
    if search != ""
      Room.where('title LIKE(?)', "%#{search}%")
      Room.where('content LIKE(?)', "%#{search}%")
    else
      Room.includes(:user).limit(20).order(id: "DESC")
    end
  end

  # ↓activehash関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :place
  belongs_to :floor
  belongs_to :style


end
