class Commentaire < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_rich_text :contenu
end
