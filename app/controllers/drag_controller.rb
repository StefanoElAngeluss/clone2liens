class DragController < ApplicationController
    def projet
        @projet = Projet.find(drag_projet_params[:id])
        @projet.insert_at(drag_projet_params[:position].to_i + 1)
    end

    private

    def drag_projet_params
        params.require(:resource).permit(:id, :position)
    end
end
