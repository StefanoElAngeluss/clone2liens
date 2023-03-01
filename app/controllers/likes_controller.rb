class LikesController < ApplicationController
    def create
        @like = current_user.likes.new(like_params)
        if !@like.save
            flash[:alert] = "Vous avez déjà aimé cet article"
        end
        redirect_to articles_path
    end

    def destroy
        @like = current_user.likes.find(params[:id])
        @like.destroy
        redirect_to articles_path
    end

    def like_params
        params.require(:like).permit(:article_id)
    end
end
