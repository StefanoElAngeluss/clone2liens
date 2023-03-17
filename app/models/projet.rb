class Projet < ApplicationRecord
    has_rich_text :contenu
    acts_as_list
end
