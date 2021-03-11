class Floor < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ワンルーム' },
    { id: 3, name: '1K' },
    { id: 4, name: '1DK' },
    { id: 5, name: '1LDK' },
    { id: 6, name: '2K' },
    { id: 7, name: '2DK' },
    { id: 8, name: '2LDK' },
    { id: 9, name: '3K' },
    { id: 10, name: '3DK' },
    { id: 11, name: '3LDK' },
    { id: 12, name: '4K以上' }
  ]

  include ActiveHash::Associations
  has_many :rooms
end