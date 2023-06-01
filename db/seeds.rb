# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# 1--- Equipments generator

equipments = ["Sèche-cheveux", "Lave-linge", "Fer à repasser", "Télévision", "Chauffage", "Réfrigérateur", "Wifi",
              "Micro-ondes", "Four", "Parking"]

puts 'Cleaning equipment database...'
Equipment.destroy_all

puts 'Creating equipments...'

equipments.each do |equipment|
  Equipment.create(name: equipment)
  puts "Creating #{equipment.name}"
end

puts "#{Equipment.count} in total - Creation completed"

# 2--- Categories generator

categories = ["Bord de mer", "Montagne", "Campagne", "Avec vue", "Piscine", "OMG!", "Parcs nationaux", "Luxe"]

puts 'Cleaning categories database...'
Category.destroy_all

puts 'Creating categories...'

categories.each do |category|
  Category.create(name: category)
  puts "Creating #{category.name}"
end

puts "#{Category.count} in total - Creation completed"

# 3--- Falts generator

# flat_1 = {
#   title: "Appartement vue mer",
#   description: "Très bel appartement T2 avec vue mer situé au 3e et dernier étage. Accès direct à la plage
#   Idéal pour un séjour agréable en bord de mer
#   Nombreuses activités à proximité : restaurants/commerces/activités
#   Appartement T2 : salon/loggia vue mer,chambre avec loggia, lit 160, salle d’eau, wc,cuisine équipée,BZ dans le salon
#   pour deux couchages supplémentaires.
#   Location serviette/gant de toilette et draps à régler a l’arrivée(10€/lit et 5€/serviettes)
#   Local vélo
#   Résidence sans ascenseur",
#   guest_nb: 4,
#   price: 95,
#   address: "Courseulles-sur-Met,Normandie,France",
#   longitude: -0.457365,
#   latitude: 49.333406,
#   owner: George
# }
