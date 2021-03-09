class Sex < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'Male' },
    { id: 3, name: 'Female' }
  ]

  include ActiveHash::Associations
  has_many :users
end