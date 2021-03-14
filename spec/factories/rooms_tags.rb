FactoryBot.define do
  factory :rooms_tag do
    title { 'オサレ' }
    content { 'aaaaaaaa'}
    place_id { 2 }
    floor_id { 2 }
    style_id { 2 }

    name { "a" }

    after(:build) do |room|
      room.image.attach(io: File.open('app/assets/images/IMG_7139.png'), filename: 'IMG_7139.png')
    end

  end
end
