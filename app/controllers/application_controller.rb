class ApplicationController < ActionController::Base
    include Pundit::Authorization
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user
    before_action :set_categories
    before_action :set_query
    before_action :set_render_cart
    before_action :initialize_cart

    def is_admin?
		unless current_user&.administrateur?
			flash[:alert] = "Vous n'êtes pas autorisé(e) à afficher cette page!"
			redirect_to root_path
		end
    end

	def set_query
		@query = Article.ransack(params[:q])
	end

    def set_render_cart
        @render_cart = true
    end

    def initialize_cart
        @cart ||= Cart.find_by(id: session[:cart_id])

        if @cart.nil?
            @cart = Cart.create
            session[:cart_id] = @cart.id
        end
    end

    private

    def set_categories
		@nav_categories = Category.where(display_in_nav: true).order(:nom)
    end

    def set_notifications
		notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
		@unread = notifications.unread
		@read = notifications.read
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in, keys: %i[
                login
                password
        ])
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[
                username
                email
                rue
                ville
                code_postale
                pays
                password
                password_confirmation
                avatar
        ])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[
                username
                rue
                ville
                code_postale
                pays
                avatar
                password
                password_confirmation
                current_password
        ])
    end

end
