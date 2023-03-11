class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user
    before_action :set_query

	def set_query
		@query = Article.ransack(params[:q])
	end

    private

    def set_notifications
		notifications = Notification.where(recipient: current_user).newest_first.limit(9)
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
