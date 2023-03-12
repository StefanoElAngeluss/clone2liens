class MembresController < ApplicationController
    before_action :authenticate_user!
    before_action :check_subscription_status

    def dashboard
    end

    private

    def check_subscription_status
        unless current_user.active_subscription
            redirect_to checkout_path(
                line_items: ['price_1MkoGYLzjEk1iOPbVesZLYv0'],
                payment_mode: 'subscription'
            ), alert: 'Vous devez avoir un abonnement actif pour accéder à cette page.'
        end
    end
end
