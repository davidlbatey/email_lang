class PagesController < ApplicationController
  def home
    redirect_to action: 'dashboard' if user_signed_in?
  end
end
