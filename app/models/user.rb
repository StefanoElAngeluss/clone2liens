class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise  :database_authenticatable, :registerable, :confirmable, :lockable,
            :recoverable, :rememberable, :validatable

    has_many :articles, dependent: :destroy
    has_many :likes
    has_many :commentaires, dependent: :destroy
    has_many :notifications, as: :recipient, dependent: :destroy

    enum role: %i[utilisateur administrateur]
    after_initialize :set_default_role, if: :new_record?

    ##### CONNEXION LOGIN ou EMAIL #####
    attr_accessor :login

    def self.find_for_database_authentication warden_condition
        conditions = warden_condition.dup
        login = conditions.delete(:login)
        where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.strip.downcase }]).first
    end
    ########## FIN UTILISATEUR ##########

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
end
