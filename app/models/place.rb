class Place < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'リビング' },
    { id: 3, name: 'ダイニング' },
    { id: 4, name: 'ベッドルーム' },
    { id: 5, name: '書斎' },
    { id: 6, name: 'キッチン' },
    { id: 7, name: '浴室' },
    { id: 8, name: 'トイレ' },
    { id: 9, name: 'クローゼット' },
    { id: 10, name: '玄関' },
    { id: 11, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :rooms
end