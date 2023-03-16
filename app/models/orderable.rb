class Orderable < ApplicationRecord
  belongs_to :produit
  belongs_to :cart

    def total
        produit.price * quantity
    end
end
