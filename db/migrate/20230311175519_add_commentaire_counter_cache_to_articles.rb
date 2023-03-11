class AddCommentaireCounterCacheToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :commentaires_count, :integer
  end
end
