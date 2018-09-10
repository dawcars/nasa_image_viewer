require 'faker'

FactoryBot.define do
  factory :image_search do 
    search_terms { Faker::Space.planet }
    center  { "JPL" }
    description { Faker::Space.moon }
    keywords { Faker::Space.galaxy }
    location { "Kennedy" }
    nasa_id { Faker::Lorem.word }
    title { Faker::Space.constellation }
    year_start { Faker::Date.between('1964-01-01', Date.today).year  }
    year_end { "2018" }
    
    skip_create
  end
  
  factory :invalid_image_search, class: ImageSearch do 
    search_terms { Faker::Space.planet }
    center  { "JPL" }
    description { Faker::Space.moon }
    keywords { Faker::Space.galaxy }
    location { "Kennedy" }
    nasa_id { Faker::Lorem.word }
    title { Faker::Space.constellation }
    year_start { "tt"  }
    year_end { "xx" }
    
    skip_create
  end
end
