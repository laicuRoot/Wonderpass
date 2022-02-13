require 'json'
require 'open-uri'

FactoryBot.define do
  url = 'https://upload.wikimedia.org/wikipedia/commons/6/64/Durdle_Door_Overview.jpg'
  location_pic = URI.open(url)
  factory :location do
    id {1}
    location_name {'Durdle Door'}
    latitude {50.62119}
    longitude {-2.2769164}
    location_description {'Durdle Door is probably the most famous stone arch anywhere in the world. It was created when the sea pierced through the Portland limestone around 10,000 years ago.'}
    category {'Natural'}
    # location_photos.attach(io: location_pic, filename: "test")
  end
end


