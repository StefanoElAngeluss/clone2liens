class UsersController < ApplicationController
    include UsersHelper
    before_action :authenticate_user!
    before_action :set_user

    def profile
        @user.update(views: @user.views + 1)
        @articles = @user.articles.order(created_at: :desc)
        @articles = Article.all.order(created_at: :desc)
        @total_views = 0

        @articles.each do |article|
            @total_views += article.views
        end
    end

    def follow
        Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @user.id)
        redirect_to profile_path(@user)
    end

    def unfollow
        current_user.followed_users.where(follower_id: current_user.id, followee_id: @user.id).destroy_all
        redirect_to profile_path(@user)
    end


    private

    def set_user
        @user = User.find(params[:id])
    end
end