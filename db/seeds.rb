STATUS = ["furnished", "unfurnished"]
RARE_BOOLEAN = [true, false, false]
BOOLEAN = [true, false]
CITY_NAME = ["Paris", "Lyon", "Marseille", "Nice", "Bordeaux"]

LYON_BOROUGH_NAME = ["Lyon 1er", "Lyon 2e", "Lyon 3e", "Lyon 4e", "Lyon 5e", "Lyon 6e", "Lyon 7e", "Lyon 8e", "Lyon 9e"]
PARIS_BOROUGH_NAME = ["Paris 1er", "Paris 2e", "Paris 3e", "Paris 4e", "Paris 5e", "Paris 6e", "Paris 7e", "Paris 8e",
                      "Paris 9e", "Paris 10e", "Paris 11e", "Paris 12e", "Paris 13e", "Paris 14e", "Paris 15e",
                      "Paris 16e", "Paris 17e", "Paris 18e", "Paris 19e", "Paris 20e"]
MARSEILLE_BOROUGH_NAME = ["Marseille 1er", "Marseille 2e", "Marseille 3e", "Marseille 4e", "Marseille 5e",
                          "Marseille 6e", "Marseille 7e", "Marseille 8e","Marseille 9e", "Marseille 10e",
                          "Marseille 11e", "Marseille 12e", "Marseille 13e", "Marseille 14e", "Marseille 15e",
                          "Marseille 16e"]

puts 'Destroy DB'
City.destroy_all

puts 'Creating Locations...'

CITY_NAME.each do |city_name|
  City.create!(
    name: city_name
  )
end

LYON_BOROUGH_NAME.each do |lyon_borough_name|
  Borough.create!(
    name: lyon_borough_name,
    city: City.find_by(name: "Lyon")
  )
end
PARIS_BOROUGH_NAME.each do |paris_borough_name|
  Borough.create!(
    name: paris_borough_name,
    city: City.find_by(name: "Paris")
  )
end
MARSEILLE_BOROUGH_NAME.each do |marseille_borough_name|
  Borough.create!(
    name: marseille_borough_name,
    city: City.find_by(name: "Marseille")
  )
end

puts 'Creating Apartments...'

100.times do
  Apartment.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    status: STATUS.sample,
    rooms: rand(1..5),
    surface: rand(15..120),
    city: City.find_by(name: "Lyon"),
    balcony: RARE_BOOLEAN.sample,
    chimney: RARE_BOOLEAN.sample,
    elevator: BOOLEAN.sample
  )
end

puts 'Finished!'
