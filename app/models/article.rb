class Article < ApplicationRecord
    extend FriendlyId

    validates :titre, presence: true, length: {minimum: 5, maximum: 50}
    validates :category_id, presence: true
    validates :contenu, presence: true
    belongs_to :user

    has_rich_text :contenu
    has_one :content, class_name: 'ActionText::RichText', as: :record, dependent: :destroy

    belongs_to :category
    has_many :commentaires, dependent: :destroy
    has_many :likes
    has_many :taggables, dependent: :destroy
    has_many :tags, through: :taggables

    friendly_id :titre, use: %i[ slugged finders history ]
    def should_generate_new_friendly_id?
        titre_changed? || slug.blank?
    end

    enum :status, { brouillon: 0, publier: 1, archiver: 2 }, _suffix: true

    #### Single image upload ####
	# has_one_attached :file, dependent: :destroy
	# has_one_attached :image, dependent: :destroy
	#### Multiple images upload ####
	has_many_attached :images

    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user

    def self.ransackable_attributes(auth_object = nil)
        %w[ titre contenu user email ]
    end
    def self.ransackable_associations(auth_object = nil)
        %w[ titre contenu user email ]
    end

end
