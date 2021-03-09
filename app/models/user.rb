class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    validates :name, presence: true
    validates :sex_id, presence: true
    validates :sex_id, numericality: { other_than: 1 } 

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :sex
    
end
