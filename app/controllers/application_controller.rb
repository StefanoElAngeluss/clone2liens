class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email , :password, :password_confirmation])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[username rue ville code_postale pays])
    end

    private

    def set_notifications
		notifications = Notification.where(recipient: current_user).newest_first.limit(9)
		@unread = notifications.unread
		@read = notifications.read
    end
end
