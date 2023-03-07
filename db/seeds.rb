# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# puts "--------------------------------"
# puts "lancement de la mis en place de la base de données"

# puts "--------------------------------"
# puts "création des utilisateurs"
# User.create(
#     username: "stefano",
#     email: "stefano@mail.com",
#     password: "123456",
#     password_confirmation: "123456")
# User.create(
#     username: "john",
#     email: "john@mail.com",
#     password: "123456",
#     password_confirmation: "123456")

# puts "--------------------------------"
# puts "création des articles"
# 10.times do |x|
#     Article.create(
#         titre: "Pretty Titre #{x}",
#         contenu: "Wafer cookie jelly gummi bears sweet roll pudding. Tootsie roll bear claw liquorice tootsie roll marzipan fruitcake macaroon gummi bears powder. Jelly-o pudding I love chocolate bar lemon drops apple pie.", user_id: User.first.id
#     )
# end
# puts "--------------------------------"
# puts "Base de données de développement envoyée en #{Time.now.to_i} seconds"