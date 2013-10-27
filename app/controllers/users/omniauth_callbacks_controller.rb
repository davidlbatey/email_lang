class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    puts request.env["omniauth.auth"]

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def pocket
    current_user.add_pocket request.env["omniauth.auth"]
    redirect_to dashboard_path
  end

  def readability
    current_user.add_readability request.env["omniauth.auth"]
    redirect_to dashboard_path
  end

  def vimeo
    current_user.add_vimeo request.env["omniauth.auth"]
    redirect_to dashboard_path
  end
end
