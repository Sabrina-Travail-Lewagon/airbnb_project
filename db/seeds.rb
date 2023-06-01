# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'
require 'open-uri'
# On va chercher le fichier
filepath = "./app/assets/files/dataset_airbnb.json"

# On lit le fichier
serial_airbnb = File.read(filepath)
# On le parse
data = JSON.parse(serial_airbnb)

puts "Cleaning database..."
Flat.destroy_all
# puts "Creating Equipments"
# # On va remplir les équipements
# equipements = ['Wifi', 'Machine à laver Disco', 'Lave vaisselle sanglant', 'poupée Chucky', 'Clown', 'Serviettes Serial killer', 'Couvertures']
# equipements.each do |equipement|
#   equipement = Equipment.new(name: equipement)
# end
# equipement.save
# puts "Equipments Done!"

# puts "Creating Categories"
# # On va remplir les équipements
# categories = ['Bords de mer', 'Maisons hantées', 'Campagne', 'bateaux', 'Chateau hanté', 'Maison à crime']
# categories.each do |category|
#   category = Category.new(name: category)
# end
# categorie.save
# puts "Categories Done!"

puts "Creating flats..."
puts "Creating seed"
# On itère sur le fichier pour récupérer les éléments
data.each do |item|
  # On va charger un équipement par défaut et une catégorie par défaut
  equipment = Equipment.find_or_create_by(name: 'Default Equipment')
  category = Category.find_or_create_by(name: 'Default Category')
  # On va récupérer les photos, qu'on stocke dans un tableau
  picture_urls = item['photos']
  # On instancie le flat
  flat = Flat.new(
    title: item['name'],
    description: item['description'],
    # Autres attributs du modèle Flat
    address: item['address'],
    guest_nb: item['numberOfGuests'],
    price: item['pricing']['rate']['amount'],
    longitude: item['location']['lng'],
    latitude: item['location']['lat'],
    equipment: equipment,
    category: category,
    user_id: 1
  )
  # On va itérer sur le tableau des photos et les attachés
  picture_urls.each do |picture_url|
    file = URI.open(picture_url['pictureUrl'])
    # Associer la photo au modèle Flat
    flat.photos.attach(io: file, filename: picture_url['pictureUrl'], content_type: "image/png")
  end

  # Sauvegarder l'objet Flat
  flat.save
end

puts "Flats Done"
