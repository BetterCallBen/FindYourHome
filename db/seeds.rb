STATUS = ["furnished", "unfurnished"]
ADDRESS = ["Paris, France", "Lyon, France", "London, UK", "New York, USA"]

puts 'Destroy all flats'
Apartment.destroy_all
puts 'Creating Apartments...'

50.times do
  Apartment.create!(
    name: Faker::Company.name,
    address: ADDRESS.sample,
    status: STATUS.sample,
    rooms: rand(1..5),
    surface: rand(15..120)
  )
end

puts 'Finished!'
