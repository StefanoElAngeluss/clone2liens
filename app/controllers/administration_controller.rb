class AdministrationController < ApplicationController
    before_action :authenticate_user!
    def index
        if current_user && current_user.utilisateur?
            redirect_to root_path, alert: "Vous n'êtes pas autoriser à afficher cette page!"
        end
    end

    def articles
        @articles = Article.all.includes(:user).order(created_at: :desc)
    end

    def commentaires
    end

    def users
        @users = User.all.order(created_at: :asc)
    end

    def show_article
        @article = Article.includes(:user, commentaires: [:user, :rich_text_contenu]).find(params[:id])
        @user = User.includes(:user).find(params[:id])
    end
end
