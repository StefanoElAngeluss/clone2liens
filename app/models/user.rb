class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise  :database_authenticatable, :registerable, :confirmable,
            :recoverable, :rememberable, :validatable, :lockable,
            :omniauthable, omniauth_providers: [:google_oauth2]

    has_many :articles, dependent: :destroy
    has_many :likes
    has_many :commentaires, dependent: :destroy
    has_many :notifications, as: :recipient, dependent: :destroy
    has_many :listes, dependent: :destroy

    ########## FOLLOWERS FOLLOWINGS ##########
    # This access the Relationship object.
    has_many :followed_users,
            foreign_key: :follower_id,
            class_name: 'Relationship',
            dependent: :destroy

    # This accesses the user through the relationship object.
    has_many :followees, through: :followed_users, dependent: :destroy

    # This access the Relationship object.
    has_many :following_users,
            foreign_key: :followee_id,
            class_name: 'Relationship',
            dependent: :destroy

    # This accesses the user through the relationship object.
    has_many :followers, through: :following_users, dependent: :destroy
    ########## FIN FOLLOWERS FOLLOWINGS ##########

    ########## AVATAR ##########
    has_one_attached :avatar
    after_commit :add_default_avatar, on: %i[ create update ]

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
    ########## FIN AVATAR ##########

    ########## CONNEXION LOGIN ou EMAIL ##########
    enum role: %i[utilisateur administrateur]
    after_initialize :set_default_role, if: :new_record?
    attr_accessor :login

    def self.find_for_database_authentication warden_condition
        conditions = warden_condition.dup
        login = conditions.delete(:login)
        where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.strip.downcase }]).first
    end
    ########## FIN CONNEXION LOGIN ou EMAIL ##########

    ########## OMNIAUTH GOOGLE ##########
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            user.username = auth.info.name # assuming the user model has a name
            user.avatar_url = auth.info.image # assuming the user model has an image
            # If you are using confirmable and the provider(s) you use validate emails,
            # uncomment the line below to skip the confirmation emails.
            # user.skip_confirmation!
        end
    end
    ########## FIN OMNIAUTH GOOGLE ##########

    ########## STRIPE PAY ##########
    ########## FIN STRIPE PAY ##########

    def self.ransackable_attributes(auth_object = nil)
        %w[ username email ]
    end
    def self.ransackable_associations(auth_object = nil)
        %w[ username email ]
    end

    private

    def set_default_role
        self.role ||= :utilisateur
    end

    def add_default_avatar
        return if avatar.attached?

        avatar.attach(
            io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.png')),
            filename: 'default_avatar.png',
            content_type: 'image/png'
        )
    end
end
