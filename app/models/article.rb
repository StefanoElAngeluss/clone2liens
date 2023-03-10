class Article < ApplicationRecord
    validates :titre, presence: true, length: {minimum: 5, maximum: 50}
    validates :contenu, presence: true
    belongs_to :user

    has_rich_text :contenu
    has_many :likes
    has_many :commentaires, dependent: :destroy

    #### Single image upload ####
	# has_one_attached :image
	#### Multiple images upload ####
	has_one_attached :file, dependent: :destroy

    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user

    def self.ransackable_attributes(auth_object = nil)
        %w[ titre contenu user email ]
    end
    def self.ransackable_associations(auth_object = nil)
        %w[ titre contenu user email ]
    end

end
