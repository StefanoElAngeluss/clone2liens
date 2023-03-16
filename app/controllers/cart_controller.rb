class CartController < ApplicationController
    def show
        @render_cart = false
    end

    def add
        @produit = Produit.find_by(id: params[:id])
        quantity = params[:quantity].to_i
        current_orderable = @cart.orderables.find_by(produit_id: @produit.id)
        if current_orderable && quantity > 0
            current_orderable.update(quantity:)
        elsif quantity <= 0
            current_orderable.destroy
        else
            @cart.orderables.create(produit: @produit, quantity:)
        end
        redirect_to produits_path
    end

    def remove
        Orderable.find_by(id: params[:id]).destroy
        redirect_to produits_path
    end
end
