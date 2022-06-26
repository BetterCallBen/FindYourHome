STATUS = ["furnished", "unfurnished"]
RARE_BOOLEAN = [true, false, false]
BOOLEAN = [true, false]
CITY = [{ name: "Paris", insee_code: "75056" }, { name: "Lyon", insee_code: "69123" },
        { name: "Marseille", insee_code: "13055" }, { name: "Nice", insee_code: "06088" },
        { name: "Bordeaux", insee_code: "33063" }, { name: "Toulouse", insee_code: "31555" },
        { name: "Nantes", insee_code: "44109" }, { name: "Lille", insee_code: "59350" }]
LYON_CITIES = [{name: "Lyon", insee_code: "69123"}, { name: "Charbonniere les bains", insee_code: "69044"},
               {name: "Tassin la demi-lune", insee_code: "69244"}, { name: "Villefranche-sur-Saone", insee_code: "69264"},
               {name: "Ecully", insee_code: "69081"}, { name: "Villeurbanne", insee_code: "69266"},
               {name: "Albigny-sur-Saône", insee_code: "69003"}, { name: "Bron", insee_code: "69029"},
               {name: "Caluire-et-Cuire", insee_code: "69034"}, { name: "Champagne-au-Mont-d'Or ", insee_code: "69040"}]
LYON_BOROUGH = [{ name: "Lyon 1er", insee_code: "69381" }, { name: "Lyon 2ème", insee_code: "69382" },
                { name: "Lyon 3ème", insee_code: "69383" }, { name: "Lyon 4ème", insee_code: "69384" },
                { name: "Lyon 5ème", insee_code: "69385" }, { name: "Lyon 6ème", insee_code: "69386" },
                { name: "Lyon 7ème", insee_code: "69387" }, { name: "Lyon 8ème", insee_code: "69388" },
                { name: "Lyon 9ème", insee_code: "69389" }]
PARIS_BOROUGH = [{ name: "Paris 1er", insee_code: "75101" }, { name: "Paris 2ème", insee_code: "75102" },
                 { name: "Paris 3ème", insee_code: "75103" }, { name: "Paris 4ème", insee_code: "75104" },
                 { name: "Paris 5ème", insee_code: "75105" }, { name: "Paris 6ème", insee_code: "75106" },
                 { name: "Paris 7ème", insee_code: "75107" }, { name: "Paris 8ème", insee_code: "75108" },
                 { name: "Paris 9ème", insee_code: "75109" }, { name: "Paris 10ème", insee_code: "75110" },
                 { name: "Paris 11ème", insee_code: "75111" }, { name: "Paris 12ème", insee_code: "75112" },
                 { name: "Paris 13ème", insee_code: "75113" }, { name: "Paris 14ème", insee_code: "75114" },
                 { name: "Paris 15ème", insee_code: "75115" }, { name: "Paris 16ème", insee_code: "75116" },
                 { name: "Paris 17ème", insee_code: "75117" }, { name: "Paris 18ème", insee_code: "75118" },
                 { name: "Paris 19ème", insee_code: "75119" }, { name: "Paris 20ème", insee_code: "75120" }]
MARSEILLE_BOROUGH = [{ name: "Marseille 1er", insee_code: "13201" }, { name: "Marseille 2ème", insee_code: "13202" },
                     { name: "Marseille 3ème", insee_code: "13203" }, { name: "Marseille 4ème", insee_code: "13204" },
                     { name: "Marseille 5ème", insee_code: "13205" }, { name: "Marseille 6ème", insee_code: "13206" },
                     { name: "Marseille 7ème", insee_code: "13207" }, { name: "Marseille 8ème", insee_code: "13208" },
                     { name: "Marseille 9ème", insee_code: "13209" }, { name: "Marseille 10ème", insee_code: "13210" },
                     { name: "Marseille 11ème", insee_code: "13211" }, { name: "Marseille 12ème", insee_code: "13212" },
                     { name: "Marseille 13ème", insee_code: "13213" }, { name: "Marseille 14ème", insee_code: "13214" },
                     { name: "Marseille 15ème", insee_code: "13215" }, { name: "Marseille 16ème", insee_code: "13216" }]

puts 'Destroy DB'
City.destroy_all

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
# PARIS_BOROUGH.each do |paris_borough|
#   Borough.create!(
#     name: paris_borough[:name],
#     insee_code: paris_borough[:insee_code],
#     city: City.find_by(name: "Paris")
#   )
# end
# MARSEILLE_BOROUGH.each do |marseille_borough|
#   Borough.create!(
#     name: marseille_borough[:name],
#     insee_code: marseille_borough[:insee_code],
#     city: City.find_by(name: "Marseille")
#   )
# end

puts 'Creating Apartments...'
lyon = City.find_by(name: "Lyon")

## flats in Lyon to rent
rand(200..220).times do
  Apartment.create!(
    project: "rent",
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph,
    price: rand(500..1200),
    apartment_type: "flat",
    address: Faker::Address.full_address,
    status: STATUS.sample,
    rooms: rand(1..5),
    surface: rand(15..120),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    parking: BOOLEAN.sample,
    cellar: false,
    garden: false,
    terrace: RARE_BOOLEAN.sample,
    borough_id: Borough.where(city: lyon).sample.id
  )
end
## houses in Lyon to rent
rand(120..150).times do
  Apartment.create!(
    project: "rent",
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: rand(700..2500),
    apartment_type: "house",
    status: STATUS.sample,
    rooms: rand(3..9),
    surface: rand(50..300),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: false,
    parking: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    borough_id: Borough.where(city: lyon).sample.id
  )
end

# flats not in Lyon to rent
rand(40..70).times do
  Apartment.create!(
    project: "rent",
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: rand(756..2500),
    apartment_type: "flat",
    status: STATUS.sample,
    rooms: rand(1..5),
    surface: rand(15..120),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    parking: BOOLEAN.sample,
    cellar: false,
    garden: false,
    terrace: RARE_BOOLEAN.sample
  )
end

## houses not in Lyon to rent
100.times do
  Apartment.create!(
    project: "rent",
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: rand(756..2500),
    apartment_type: "house",
    status: STATUS.sample,
    rooms: rand(3..9),
    surface: rand(50..300),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: false,
    parking: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
  )
end

## flats in Lyon to buy
rand(200..220).times do
  Apartment.create!(
    project: "buy",
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph,
    price: rand(100_000..1_200_000),
    apartment_type: "flat",
    address: Faker::Address.full_address,
    status: STATUS.sample,
    rooms: rand(1..5),
    surface: rand(15..120),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    parking: BOOLEAN.sample,
    cellar: false,
    garden: false,
    terrace: RARE_BOOLEAN.sample,
    borough_id: Borough.where(city: lyon).sample.id
  )
end
## houses in Lyon to buy
rand(120..150).times do
  Apartment.create!(
    project: "buy",
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: rand(100_000..1_000_000),
    apartment_type: "house",
    status: STATUS.sample,
    rooms: rand(3..9),
    surface: rand(50..300),
    city: lyon,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: false,
    parking: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
    borough_id: Borough.where(city: lyon).sample.id
  )
end

# flats not in Lyon to buy
rand(40..70).times do
  Apartment.create!(
    project: "buy",
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: rand(75_600..2_500_000),
    apartment_type: "flat",
    status: STATUS.sample,
    rooms: rand(1..5),
    surface: rand(15..120),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample,
    parking: BOOLEAN.sample,
    cellar: false,
    garden: false,
    terrace: RARE_BOOLEAN.sample
  )
end

## houses not in Lyon to buy
100.times do
  Apartment.create!(
    project: "buy",
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: rand(75_600..2_500_000),
    apartment_type: "house",
    status: STATUS.sample,
    rooms: rand(3..9),
    surface: rand(50..300),
    city: City.where.not(name: "Lyon").sample,
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: false,
    parking: BOOLEAN.sample,
    cellar: RARE_BOOLEAN.sample,
    garden: BOOLEAN.sample,
    terrace: RARE_BOOLEAN.sample,
  )
end

puts 'Finished!'
