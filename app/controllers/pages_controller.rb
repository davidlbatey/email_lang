class PagesController < ApplicationController
  def home
    redirect_to action: 'dashboard' if user_signed_in?
  end

  def dashboard
    @contacts = current_user.contacts.all
  end
end
