class ListesController < ApplicationController
  before_action :set_liste, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /listes or /listes.json
  def index
    @listes = current_user.listes
  end

  # GET /listes/1 or /listes/1.json
  def show
  end

  # GET /listes/new
  def new
    @liste = Liste.new
  end

  # GET /listes/1/edit
  def edit
  end

  # POST /listes or /listes.json
  def create
    @liste = Liste.new(liste_params)
    @liste.user = current_user

    respond_to do |format|
      if @liste.save
        format.html { redirect_to liste_url(@liste), notice: "Liste was successfully created." }
        format.json { render :show, status: :created, location: @liste }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @liste.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listes/1 or /listes/1.json
  def update
    @liste.user = current_user
    respond_to do |format|
      if @liste.update(liste_params)
        format.html { redirect_to listes_url, notice: "Liste was successfully updated." }
        format.json { render :show, status: :ok, location: @liste }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @liste.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listes/1 or /listes/1.json
  def destroy
    @liste.destroy

    respond_to do |format|
      format.html { redirect_to listes_url, notice: "Liste was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liste
      @liste = Liste.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def liste_params
      params.require(:liste).permit(:titre, :contenu, :completed)
    end
end
