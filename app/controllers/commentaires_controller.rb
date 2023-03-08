class CommentairesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_art

    def create
        @commentaire = @article.commentaires.create(commentaire_params)
        @commentaire.user = current_user

        if @commentaire.save
            flash[:notice] = "Votre commentaire à bien été créé."
            redirect_to article_path(@article)
        else
            flash[:alert] = "ATTENTION !!! La création de votre commentaire à eu un problème."
            redirect_to article_path(@article)
        end
    end

    def update
        @commentaire = @article.commentaires.find(params[:id])

        respond_to do |format|
            if @commentaire.update(commentaire_params)
                format.html { redirect_to article_path(@article), notice: "Votre commentaire à bien été modifié." }
            else
                format.html { redirect_to article_path(@article), alert: "ATTENTION !!! La modification de votre commentaire à eu un problème." }
            end
        end
    end

    def destroy
        @commentaire = @article.commentaires.find(params[:id])
        @commentaire.destroy
        redirect_to article_path(@article)
    end

    private

    def set_art
        @article = Article.find(params[:article_id])
    end

    def commentaire_params
        params.require(:commentaire).permit(:contenu)
    end
end
