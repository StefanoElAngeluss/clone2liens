class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def profile
        @user.update(views: @user.views + 1)
        @articles = @user.articles.order(created_at: :desc)
        @articles = Article.all.order(created_at: :desc)
        @total_views = 0

        @articles.each do |article|
            @total_views += article.views
        end
        # Achat stripe
        @users = User.where.not(id: current_user)
        return unless current_user
        return if current_user.payment_processor.nil?

        @portal_session = current_user.payment_processor.billing_portal
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end