class Commentaire < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: true
  has_rich_text :contenu

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: "Notification"

  private

  def notify_recipient
    CommentaireNotification.with(
        commentaire: self,
        article: article).deliver_later(article.user)
  end

  def cleanup_notifications
    notifications_as_commentaire.destroy_all
  end
end
