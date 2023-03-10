class AdministrationController < ApplicationController
    before_action :authenticate_user!
    def index
        if current_user && current_user.utilisateur?
        redirect_to root_path, alert: "Vous n'êtes pas autoriser à afficher cette page!"
        end
    end

    def articles
        @articles = Article.all.includes(:user, :commentaires)
    end

    def commantaires
    end

    def users
        @users = User.all
    end

    def show_article
        @article = Article.includes(:user, commentaires: [:user, :rich_text_body]).find(params[:id])
        @user = User.includes(:user).find(params[:id])
    end
end
