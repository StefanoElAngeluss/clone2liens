class Category < ApplicationRecord
    validates :nom, presence: true, uniqueness: true
    has_many :articles
end
