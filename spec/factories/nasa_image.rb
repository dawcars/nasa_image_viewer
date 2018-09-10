require 'faker'

FactoryBot.define do
  factory :nasa_image do |f|
    f.media_type { "image" }
    f.center { "JPL" }
    f.description { Faker::Space.moon }
    f.keywords { Faker::Space.galaxy }
    f.nasa_id { Faker::Lorem.word }
    f.title { Faker::Space.constellation }
    f.date_image_created { Faker::Date.between('1964-01-01', Date.today).year  }
    f.image_collection_url { "https://images-assets.nasa.gov/image/PIA12235/collection.json" }
    f.thumbnail_url { "https://images-assets.nasa.gov/image/PIA12235/PIA12235~thumb.jpg" }
  end
end