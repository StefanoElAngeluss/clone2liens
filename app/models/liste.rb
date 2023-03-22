class Liste < ApplicationRecord
  belongs_to :user
  has_rich_text :contenu
end
