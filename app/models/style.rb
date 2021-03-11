class Style < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '一人暮らし' },
    { id: 3, name: '二人暮らし' },
    { id: 4, name: '三人家族' },
    { id: 5, name: '四人家族' },
    { id: 6, name: '五人家族' },
    { id: 7, name: 'それ以上の大家族' },
    { id: 8, name: 'シェアハウス' },
    { id: 9, name: '寮' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :rooms
end