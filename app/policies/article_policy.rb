class ArticlePolicy < ApplicationPolicy
    attr_reader :user, :article

    def initialize(user, article)
        @user = user
        @article = article
    end

    def create?
        user.administrateur? || !article.published
    end

    def edit?
        user.administrateur? || !article.published
    end

end