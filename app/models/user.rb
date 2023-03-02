class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

    has_many :articles
    has_many :likes

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

    private

    def set_default_role
        self.role ||= :utilisateur
    end
end
