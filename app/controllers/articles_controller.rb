class ArticlesController < ApplicationController
    include Pagy::Backend
    before_action :authenticate_user!, only: %i[ index show ]
    before_action :set_article, only: %i[ show edit update destroy pdf ]
    before_action :set_cats

    # GET /articles or /articles.json
    def index
        if params[:category].blank?
            @articles = Article.all.order(created_at: :desc)
        else
            @articles = Article.where(category_id: category_id).order(created_at: :desc)
            @category_id = Category.find_by(nom: params[:category_id])
        end
        @pagy, @articles = pagy(Article.order(created_at: :desc), items: 4)
        # @pagy, @articles = pagy(Article.order(created_at: :desc))
    end

    # GET /articles/1 or /articles/1.json
    def show
        # ajouter les views au articles avec incrementation de 1
        @article.update(views: @article.views + 1)
        @commentaires = @article.commentaires.order(created_at: :desc)

        # if status === 1 || current_user.administrateur?
        #   @article.update(views: @article.views + 1)
        #   @comments = @article.comments.includes(:user, :rich_text_body).order(created_at: :desc)

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
        if current_user != @article.user
            redirect_to articles_path, alert: "Vous n'êtes pas autoriser à modifier cet article!"
        end
    end

    # POST /articles or /articles.json
    def create
        @article = Article.new(article_params.except(:tags))
        @article.user = current_user
        create_or_delete_articles_tags(@article, params[:article][:tags])

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
        create_or_delete_articles_tags(@article, params[:article][:tags])
        respond_to do |format|
        if @article.update(article_params.except(:tags))
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

    def pdf
        pdf = Prawn::Document.new
        pdf.text @article.titre,size: 48, style: :bold
        # afficer le contenu avec l'encodage pour trix
        pdf.move_down 40
        pdf.text @article.contenu.to_plain_text, size: 14, style: :normal
        pdf.move_down 20

        # afficher l'image de l'article dans le pdfww
        if @article.file.present?
            file = StringIO.open(@article.file.download)
            pdf.image file, fit: [540, 500], valign: :center
        else
            pdf.text "Cet article n'as d'image(s).", color: 'FF0000', valign: :center, size: 16, style: :bold
        end

        send_data(pdf.render,
            filename: "#{@article.titre}.pdf",
            type: 'application/pdf',
            disposition: 'inline')
    end

    private

    def create_or_delete_articles_tags(article, tags)
        article.taggables.destroy_all
        tags = tags.strip.split(",")
        tags.each do |tag|
            article.tags << Tag.find_or_create_by(name: tag)
        end
    end

    def set_article
    @article = Article.friendly.find(params[:id])

    redirect_to @article, status: :moved_permanently if params[:id] != @article.slug
    end

    def set_cats
    @categories = Category.all.order(:nom)
    end

    def article_params
    params.require(:article).permit(:titre, :contenu, :file, :category_id, :tags)
    end

    def mark_notifications_as_read
        if current_user
            notification_to_mark_as_read = @article.notifications_as_article.where(recipient: current_user)
            notification_to_mark_as_read.update_all(read_at: Time.zone.now)
        end
    end
end
