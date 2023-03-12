class PagesController < ApplicationController
  def accueil
  end

  def boutique
    @users = User.where.not(id: current_user)
    return unless current_user
    return if current_user.payment_processor.nil?

    @portal_session = current_user.payment_processor.billing_portal
  end

  def contact
  end

  def about
  end
end
