FactoryBot.define do
  factory :room do
    title { 'オサレ' }
    content { 'aaaaaaaa'}
    place_id { 2 }
    floor_id { 2 }
    style_id { 2 }

    after(:build) do |room|
      room.image.attach(io: File.open('app/assets/images/IMG_7139.png'), filename: 'IMG_7139.png')
    end

  end
end
