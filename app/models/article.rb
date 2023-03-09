class Article < ApplicationRecord
    validates :titre, presence: true, length: {minimum: 5, maximum: 50}
    validates :contenu, presence: true, length: {minimum: 10, maximum: 1000}
    belongs_to :user

    has_rich_text :contenu
    has_many :likes
    has_many :commentaires, dependent: :destroy

    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user, dependent: :destroy
end
