puts "--------------------------------"
puts "lancement de la mis en place de la base de données"
puts "--------------------------------"

puts "--------------------------------"
puts "création des utilisateurs"
User.create(
    username: "Stefano",
    email: "stefano@mail.com",
    role: "administrateur",
    password: "123456",
    password_confirmation: "123456")
User.create(
    username: "John",
    email: "john@mail.com",
    role: "utilisateur",
    password: "123456",
    password_confirmation: "123456")
User.create(
    username: "Jane",
    email: "jane@mail.com",
    role: "utilisateur",
    password: "123456",
    password_confirmation: "123456")
User.create(
    username: "Shane",
    email: "shane@mail.com",
    role: "utilisateur",
    password: "123456",
    password_confirmation: "123456")

puts "--------------------------------"
puts "création des catégories"
Category.create(nom: "Non catégorisé")
Category.create(nom: "Développement")
Category.create(nom: "Informatique")
Category.create(nom: "Bureautique")
Category.create(nom: "Electronique")

puts "--------------------------------"
puts "création des articles et des commentaires"
elapsed = Benchmark.measure do
    5.times do |x|
        art = Article.create(
            titre: "Pretty Titre #{x}",
            contenu: "Tootsie #{x} cookie jelly gummi bears sweet roll pudding. Wafer roll bear claw liquorice tootsie roll marzipan fruitcake macaroon gummi bears powder. Jelly-o pudding I love chocolate bar lemon drops apple pie.",
            category_id: Category.first.id,
            status: "publier",
            user_id: User.first.id)
        2.times do |y|
            art.commentaires.create(
                contenu: "Commentaire #{y} Wafer roll bear claw liquorice tootsie",
                user_id: User.second.id)
        end
    end
    5.times do |x|
        art = Article.create(
            titre: "Pretty Titre #{x}",
            contenu: "Wafer #{x} cookie jelly gummi bears sweet roll pudding. Tootsie roll bear claw liquorice tootsie roll marzipan fruitcake macaroon gummi bears powder. Jelly-o pudding I love chocolate bar lemon drops apple pie.",
            category_id: Category.second.id,
            status: "brouillon",
            user_id: User.second.id)
        2.times do |y|
            art.commentaires.create(
                contenu: "Commentaire #{y} Wafer roll bear claw liquorice tootsie",
                user_id: User.first.id)
        end
    end
    5.times do |x|
        art = Article.create(
            titre: "Pretty Titre #{x}",
            contenu: "Wafer #{x} cookie jelly gummi bears sweet roll pudding. Tootsie roll bear claw liquorice tootsie roll marzipan fruitcake macaroon gummi bears powder. Jelly-o pudding I love chocolate bar lemon drops apple pie.",
            category_id: Category.third.id,
            status: "archiver",
            user_id: User.third.id)
        2.times do |y|
            art.commentaires.create(
                contenu: "Commentaire #{y} Wafer roll bear claw liquorice tootsie",
                user_id: User.fourth.id)
        end
    end
end
puts "Envoie dans la DATABASE en #{elapsed.real} secondes"