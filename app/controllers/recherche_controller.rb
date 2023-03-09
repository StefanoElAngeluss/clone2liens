class RechercheController < ApplicationController
  def index
    @query = Article.ransack(params[:q])
    @articles = @query.result(disctinct: true)#.page(params[:page]).per(10)
  end
end