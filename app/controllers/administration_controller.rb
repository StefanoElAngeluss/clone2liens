class AdministrationController < ApplicationController
    before_action :authenticate_user!
    def index
        if current_user && current_user.utilisateur?
            redirect_to root_path, alert: "Vous n'êtes pas autoriser à afficher cette page!"
        end
    end

    def articles
        if current_user && current_user.utilisateur?
            redirect_to root_path, alert: "Vous n'êtes pas autoriser à afficher cette page!"
        else
            @articles = Article.all.order(created_at: :desc)
        end
    end

    def commentaires
        if current_user && current_user.utilisateur?
            redirect_to root_path, alert: "Vous n'êtes pas autoriser à afficher cette page!"
        else
            @commentaires = Commentaire.all.order(created_at: :desc)
        end
    end

    def users
        if current_user && current_user.utilisateur?
            redirect_to root_path, alert: "Vous n'êtes pas autoriser à afficher cette page!"
        else
            @users = User.all.order(created_at: :asc)
        end
    end

    def show_article
        @article = Article.includes(:user, commentaires: [:user]).find(params[:id])
        @article = Article.find(params[:id])
        @user = User.includes(:user).find(params[:id])
        @user = User.find(params[:id])
    end
end
