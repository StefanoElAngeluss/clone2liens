# To deliver this notification:
#
# CommentaireNotification.with(post: @post).deliver_later(current_user)
# CommentaireNotification.with(post: @post).deliver(current_user)

class CommentaireNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @article = Article.find(params[:commentaire][:article_id])
    @commentaire = Commentaire.find(params[:commentaire][:id])
    @user = User.find(@commentaire.user_id)
    "#{ @user.username } a commenter dans #{ @article.titre.truncate_words(10) }"
  end
  #
  def url
    article_path(params[:article])
  end
end
