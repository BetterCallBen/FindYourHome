STATUS = ["furnished", "unfurnished"]
RARE_BOOLEAN = [true, false, false]
BOOLEAN = [true, false]
LYON_CITIES = [{ name: "Lyon", insee_code: "69123" }, { name: "Charbonniere les bains", insee_code: "69044" },
               { name: "Tassin la demi-lune", insee_code: "69244" }, { name: "Villefranche-sur-Saone", insee_code: "69264" },
               { name: "Ecully", insee_code: "69081" }, { name: "Villeurbanne", insee_code: "69266" },
               { name: "Albigny-sur-Saône", insee_code: "69003" }, { name: "Bron", insee_code: "69029" },
               { name: "Caluire-et-Cuire", insee_code: "69034" }, { name: "Champagne-au-Mont-d'Or ", insee_code: "69040" },
               { name: "Sainte-foy-lès-lyons", insee_code: "69202" }, { name: "Dardilly", insee_code: "69072" },
               { name: "Saint-Cyr-Au-Mont-d'Or", insee_code: "69191" }, { name: "Saint-Didier-Au-Mont-d'Or", insee_code: "69194" },
               { name: "Collonge-Au-Mont-d'Or", insee_code: "69063" }, { name: "Saint-Cyr-Au-Mont-d'Or", insee_code: "69068" },
               { name: "Curis-Au-Mont-d'Or", insee_code: "69071" }, { name: "Saint-Germain-Au-Mont-d'Or", insee_code: "69207" },
               { name: "Saint-Genis-Laval", insee_code: "69204" }, { name: "Saint-Genis-Les-Oillères", insee_code: "69205" },
               { name: "Oullins", insee_code: "69149" }]
LYON_BOROUGH = [{ name: "Lyon 1er", insee_code: "69381" }, { name: "Lyon 2ème", insee_code: "69382" },
                { name: "Lyon 3ème", insee_code: "69383" }, { name: "Lyon 4ème", insee_code: "69384" },
                { name: "Lyon 5ème", insee_code: "69385" }, { name: "Lyon 6ème", insee_code: "69386" },
                { name: "Lyon 7ème", insee_code: "69387" }, { name: "Lyon 8ème", insee_code: "69388" },
                { name: "Lyon 9ème", insee_code: "69389" }]

APARTMENT_IMAGES = %w[https://images.ctfassets.net/pg6xj64qk0kh/2r4QaBLvhQFH1mPGljSdR9/39b737d93854060282f6b4a9b9893202/camden-paces-apartments-buckhead-ga-terraces-living-room-with-den_1.jpg
                      https://cf.bstatic.com/xdata/images/hotel/max1024x768/72282092.jpg?k=5eeba7eb191652ce0c0988b4c7c042f1165b7064d865b096bb48b8c48bf191b9&o=&hp=1
                      https://cdn.theblueground.com/website/static/img/paris-1-thumbnail.58117ea048647b0c1da0.jpg
                      https://image.architonic.com/prj2-3/20116834/rua-141-apartment-in-sao-paulo-architonic-3629-01-arcit18.jpg
                      https://www.aveliving.com/AVE/media/Property_Images/Florham%20Park/hero/flor-apt-living-(2)-hero.jpg?ext=.jpg
                      https://cf.bstatic.com/xdata/images/hotel/max1024x768/267316381.jpg?k=86b64cf28cd12f4c6feb7b7be23c8bcce91b2cd1be7c48a7383c4297d8d695ce&o=&hp=1
                      https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/2e/25/da/old-town-by-welcome-apartment.jpg?w=900&h=-1&s=1]

UNFURNISHED_APARTMENT_IMAGES = %w[https://www.paris-housing.com/listings/140315/real_estate_image_big_682x455/big_0_20092211340655ruelecorbusier15.jpg]
LYON_ADDRESSES = [{ address: "Rue des Capucins", borough: "Lyon 1er" }, { address: "Quai du Général Sarrail", borough: "Lyon 1er" },
                  { address: "Rue de la République", borough: "Lyon 1er" }, { address: "Rue Édouard-Herriot", borough: "Lyon 2ème" },
                  { address: "Boulevard de la Croix-Rousse", borough: "Lyon 4ème" }, { address: "Rue des Pierres-Plantées", borough: "Lyon 1er" },
                  { address: "Place Colbert", borough: "Lyon 1er" }, { address: "Place de Fourvière", borough: "Lyon 5ème" },
                  { address: "Rue de la Bombarde", borough: "Lyon 5ème" }, { address: "Rue mercière", borough: "Lyon 2ème" },
                  { address: "Place Bellecour", borough: "Lyon 2ème" }, { address: "Rue d'Ivry", borough: "Lyon 4ème" },
                  { address: "Rue de la Bourse", borough: "Lyon 1er" }, { address: "Rue Hyppolite Flandrin", borough: "Lyon 1er" },
                  { address: "Rue Saint Jean", borough: "Lyon 5ème" }, { address: "Rue Tronchet", borough: "Lyon 6ème" },
                  { address: "Place Louis Chazette", borough: "Lyon 1er" }, { address: "Place Louis Pradel", borough: "Lyon 1er" }]

puts 'Destroy DB'
City.destroy_all
User.destroy_all

puts 'Create Users'

User.create!(
  email: 'benjbdk@gmail.com',
  password: 'secret'
)

puts 'Creating Locations...'

LYON_CITIES.each do |lyon_city|
  City.create!(
    name: lyon_city[:name],
    insee_code: lyon_city[:insee_code]
  )
end

LYON_BOROUGH.each do |lyon_borough|
  Borough.create!(
    name: lyon_borough[:name],
    insee_code: lyon_borough[:insee_code],
    city: City.find_by(name: "Lyon")
  )
end

puts 'Creating Apartments...'

lyon = City.find_by(name: "Lyon")

## flats in Lyon to rent
rand(200..220).times do
  location = LYON_ADDRESSES.sample
  Apartment.create!(
    project: "rent",
    description: Faker::Lorem.paragraph,
    image_url: APARTMENT_IMAGES.sample,
    price: rand(500..1200),
    address: "#{rand(1..30)} #{location[:address]}, Lyon",
    status: STATUS.sample,
    floor: rand(1..6),
    building_floor: rand(3..6),
    rooms: a = rand(1..5),
    bedrooms: a > 1 ? a - 1 : a,
    surface: rand(15..120),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    borough: Borough.find_by(name: location[:borough])
  )
  puts Apartment.last
end

## houses in Lyon to rent
rand(120..150).times do
  location = LYON_ADDRESSES.sample
  House.create!(
    project: "rent",
    address: "#{rand(1..30)} #{location[:address]}, Lyon",
    description: Faker::Lorem.paragraph,
    image_url: "https://www.depreux-construction.com/wp-content/uploads/2018/11/depreux-construction.jpg",
    price: rand(700..2500),
    status: STATUS.sample,
    rooms: rooms = rand(3..9),
    bedrooms: rooms - rand(1..2),
    surface: rand(50..300),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    borough: Borough.find_by(name: location[:borough]),
    pool: RARE_BOOLEAN.sample
  )
  puts House.last
end

# flats not in Lyon to rent
rand(40..70).times do
  Apartment.create!(
    project: "rent",
    address: LYON_ADDRESSES.sample,
    description: Faker::Lorem.paragraph,
    image_url: APARTMENT_IMAGES.sample,
    price: rand(756..2500),
    status: STATUS.sample,
    floor: rand(1..6),
    building_floor: rand(3..6),
    rooms: a = rand(1..5),
    bedrooms: a > 1 ? a - 1 : a,
    surface: rand(15..120),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample
  )
  puts Apartment.last
end

## houses not in Lyon to rent
100.times do
  House.create!(
    project: "rent",
    address: LYON_ADDRESSES.sample,
    description: Faker::Lorem.paragraph,
    image_url: "https://www.depreux-construction.com/wp-content/uploads/2018/11/depreux-construction.jpg",
    price: rand(756..2500),
    status: STATUS.sample,
    rooms: rooms = rand(3..9),
    bedrooms: rooms - rand(1..2),
    surface: rand(50..300),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    pool: RARE_BOOLEAN.sample
  )
  puts House.last
end

## flats in Lyon to buy
rand(200..220).times do
  location = LYON_ADDRESSES.sample
  Apartment.create!(
    project: "buy",
    description: Faker::Lorem.paragraph,
    image_url: APARTMENT_IMAGES.sample,
    price: rand(100_000..1_200_000),
    address: "#{rand(1..30)} #{location[:address]}, Lyon",
    floor: rand(1..6),
    building_floor: rand(3..6),
    rooms: a = rand(1..5),
    bedrooms: a > 1 ? a - 1 : a,
    surface: rand(15..120),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    borough: Borough.find_by(name: location[:borough])
  )
  puts Apartment.last
end

## houses in Lyon to buy
rand(120..150).times do
  location = LYON_ADDRESSES.sample
  House.create!(
    project: "buy",
    address: "#{rand(1..30)} #{location[:address]}, Lyon",
    description: Faker::Lorem.paragraph,
    image_url: "https://www.depreux-construction.com/wp-content/uploads/2018/11/depreux-construction.jpg",
    price: rand(100_000..1_000_000),
    rooms: rooms = rand(3..9),
    bedrooms: rooms - rand(1..2),
    surface: rand(50..300),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    borough: Borough.find_by(name: location[:borough]),
    pool: RARE_BOOLEAN.sample
  )
  puts House.last
end

## flats not in Lyon to buy
rand(40..70).times do
  Apartment.create!(
    project: "buy",
    address: LYON_ADDRESSES.sample,
    description: Faker::Lorem.paragraph,
    image_url: APARTMENT_IMAGES.sample,
    price: rand(75_600..2_500_000),
    floor: rand(1..6),
    building_floor: rand(3..6),
    rooms: a = rand(1..5),
    bedrooms: a > 1 ? a - 1 : a,
    surface: rand(15..120),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample
  )
  puts Apartment.last
end

## houses not in Lyon to buy
100.times do
  House.create!(
    project: "buy",
    address: LYON_ADDRESSES.sample,
    description: Faker::Lorem.paragraph,
    image_url: "https://www.depreux-construction.com/wp-content/uploads/2018/11/depreux-construction.jpg",
    price: rand(75_600..2_500_000),
    rooms: rooms = rand(3..9),
    bedrooms: rooms - rand(1..2),
    surface: rand(50..300),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    garage: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    pool: RARE_BOOLEAN.sample
  )
  puts House.last
end

puts 'Finished!'

# House.create!(
#   project: "rent",
#   address: LYON_ADDRESSES.sample,
#   description: Faker::Lorem.paragraph,
#   image_url: "https://www.depreux-construction.com/wp-content/uploads/2018/11/depreux-construction.jpg",
#   price: rand(700..2500),
#   status: "furnished",
#   rooms: 6,
#   bedrooms: 4,
#   surface: 126,
#   city: City.first,
#   balcony: true,
#   chimney: true,
#   garage: false,
#   cellar: true,
#   terrace: true,
#   garden: false,
#   pool: true
# )
