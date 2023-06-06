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

# On nettoie la base de données
puts "Cleaning database..."
FlatCategory.destroy_all
FlatEquipment.destroy_all
Flat.destroy_all
User.destroy_all
Equipment.destroy_all
Category.destroy_all
# Création d'un User
puts "Creating a User"
user = User.create(email: "hugo.mickael@gmail.com", first_name: "Hugo", last_name: "Mickael", phone_number: "0756347898", password: "123456")
user.save
puts "User created"

# On va remplir les équipements
puts "Creating Equipments"
# On crée une liste d'équipements dans un array
equipments = ['Wifi', 'Machine à laver Disco', 'Lave vaisselle sanglant', 'poupée Chucky', 'Clown', 'Serviettes Serial killer', 'Couvertures']
# On itère sur l'array pour aller le mettre en BdD
equipments.each do |equipment_name|
  Equipment.create(name: equipment_name)
end
puts "Equipments Done!"

# On va remplir les catégories
puts "Creating Categories"
# On crée une liste des catégories dans un array
categories = ['Bords de mer', 'Maisons hantées', 'Campagne', 'bateaux', 'Chateau hanté', 'Maison à crime']
# On itère sur l'array pour aller le mettre en BdD
categories.each do |category_name|
  Category.create(name: category_name)
end
puts "Categories Done!"

puts "Creating flats..."
puts "Creating seed"

# On va chercher le fichier
filepath = "db/data/dataset_airbnb.json"
# On lit le fichier
serial_airbnb = File.read(filepath)
# On le parse
data = JSON.parse(serial_airbnb)
i = 1
data.first(5).each do |item|
  # On va charger un équipement par défaut et une catégorie par défaut
  # equipment = Equipment.find_by(name: 'Machine à laver Disco')
  # category = Category.find_by(name: 'Maisons hantées')
  # On instancie le flat
  flat = Flat.new(
    title: item['name'],
    description: item['roomType'],
    address: item['address'],
    guest_nb: item['numberOfGuests'],
    price: item['pricing']['rate']['amount'],
    longitude: item['location']['lng'],
    latitude: item['location']['lat'],
    categories: Category.all.sample(2),
    equipments: Equipment.all.sample(2),
    owner: User.first
  )
  # On va récupérer les photos, qu'on stocke dans un tableau
  picture_urls = item['photos']
  # On va itérer sur le tableau des photos et les attachés
  picture_urls.each do |picture_url|
    file = URI.open(picture_url['pictureUrl'])
    # Associer la photo au modèle Flat
    flat.photos.attach(io: file, filename: 'photo.png', content_type: 'image/png')
  end
  # On lie les catégories et les équipements au flat
  # flat.categories << category
  # flat.equipments << equipment
  # Sauvegarder l'objet Flat

  flat.save!
  puts "Flat #{i} created"
  i += 1
end
# Deuxième liste d'appart avec d'autres catégories et equipements.
  # data.first(10).each do |item|
  #   # On va charger un équipement par défaut et une catégorie par défaut
  #   equipment2 = Equipment.find_by(name: 'Wifi')
  #   category2 = Category.find_by(name: 'Bords de mer')
  #   # On instancie le flat
  #   flat = Flat.new(
  #     title: item['name'],
  #     description: item['roomType'],
  #     address: item['address'],
  #     guest_nb: item['numberOfGuests'],
  #     price: item['pricing']['rate']['amount'],
  #     longitude: item['location']['lng'],
  #     latitude: item['location']['lat'],
  #     user_id: 1
  #   )
  #   # On va récupérer les photos, qu'on stocke dans un tableau
  #   picture_urls = item['photos']
  #   # On va itérer sur le tableau des photos et les attachés
  #   picture_urls.each do |picture_url|
  #     file = URI.open(picture_url['pictureUrl'])
  #     # Associer la photo au modèle Flat
  #     flat.photos.attach(io: file, filename: 'photo.png', content_type: 'image/png')
  #   end
  #   # On lie les catégories et les équipements au flat
  #   flat.categories << category2
  #   flat.equipments << equipment2
  #   # Sauvegarder l'objet Flat
  #   flat.save!
  # end

puts "#{Flat.count} Flats Done"
puts "Voici le compte utilisateur que vous pouvez utiliser :"
puts "-------------------------------------------------------"
puts "User crée, login : hugo.mickael@gmail, password: 123456"
