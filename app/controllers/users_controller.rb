class UsersController < ApplicationController
  def youtube
    current_user.add_youtube

    redirect_to dashboard_path
  end
end
