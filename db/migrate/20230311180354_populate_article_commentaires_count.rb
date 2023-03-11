class PopulateArticleCommentairesCount < ActiveRecord::Migration[7.0]
  def change
    Article.all.each do |art|
      Article.reset_counters(art.id, :commentaires)
    end
  end
end
