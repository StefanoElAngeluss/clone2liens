class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise  :database_authenticatable, :registerable, :confirmable, :lockable,
            :recoverable, :rememberable, :validatable

    has_many :articles, dependent: :destroy
    has_many :likes
    has_many :commentaires, dependent: :destroy
    has_many :notifications, as: :recipient, dependent: :destroy

    has_one_attached :avatar
    after_commit :add_default_avatar, on: %i[ create update ]


    ##### CONNEXION LOGIN ou EMAIL #####
    enum role: %i[utilisateur administrateur]
    after_initialize :set_default_role, if: :new_record?
    attr_accessor :login

    def self.find_for_database_authentication warden_condition
        conditions = warden_condition.dup
        login = conditions.delete(:login)
        where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.strip.downcase }]).first
    end

    def set_default_role
        self.role ||= :utilisateur
    end
    ########## FIN CONNEXION LOGIN ou EMAIL ##########

    def self.ransackable_attributes(auth_object = nil)
        %w[ username email ]
    end
    def self.ransackable_associations(auth_object = nil)
        %w[ username email ]
    end

    def avatar_thumbnail
        if avatar.attached?
            avatar.variant(resize_to_limit: [150, 150]).processed
        else
            "/default_profile.png"
        end
    end

    def avatar_navbar
        avatar.variant(resize_to_limit: [30, 30]).processed
    end

    private

    def add_default_avatar
        return if avatar.attached?

        avatar.attach(
            io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.png')),
            filename: 'default_avatar.png',
            content_type: 'image/png'
        )
    end
end
