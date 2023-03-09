class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: %i[ index show ]
    before_action :set_article, only: %i[ show edit update destroy ]

    # GET /articles or /articles.json
    def index
        @articles = Article.all.order(created_at: :desc)
    end

  # GET /articles/1 or /articles/1.json
  def show
    # ajouter les views au articles avec incrementation de 1
    @article.update(views: @article.views + 1)
    @commentaires = @article.commentaires.order(created_at: :desc)

    # if status === 1 || current_user.administrateur?
    #   @article.update(views: @article.views + 1)
    #   @comments = @article.comments.includes(:user, :rich_text_body).order(created_at: :desc)

    #   ahoy.track 'Article vue', article_id: @article.id

    mark_notifications_as_read
    # else
    #   redirect_to articles_path, notice: "L'article publier n'as pas encore été axcepter par l'admin !"
    # end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article.user = current_user
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:titre, :contenu)
    end

    def mark_notifications_as_read
        if current_user
            notification_to_mark_as_read = @article.notifications_as_article.where(recipient: current_user)
            notification_to_mark_as_read.update_all(read_at: Time.zone.now)
        end
    end
end
