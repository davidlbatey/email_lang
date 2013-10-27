class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :pocket, :readability]

  has_many :contacts, :dependent => :destroy
  has_many :accounts, :dependent => :destroy

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create( name: data["name"],
                          email: data["email"],
                          picture: data["image"],
                          provider: access_token.provider,
                          uid: access_token.uid,
                          password: Devise.friendly_token[0,20],
                          token: access_token.credentials.token,
                          refresh_token: access_token.credentials.refresh_token,
                          token_expire: Time.at(access_token.credentials.expires_at)
                        )
    else
      user.update token: access_token.credentials.token,
                  token_expire: Time.at(access_token.credentials.expires_at)
    end

    user
  end

  def refresh_token!
    if Time.now > token_expire
      response = HTTParty.post "https://accounts.google.com/o/oauth2/token",
                               :body => token_data

      if response.success?
        update token: response["access_token"],
               token_expire: Time.now + response["expires_in"]
      end
    end
  end

  def add_pocket auth
    accounts.create :action => "read",
                    :provider => "pocket",
                    :token => auth.credentials.token
  end

  def add_readability auth
    accounts.create :action => "read",
                    :provider => "readability",
                    :token => auth.credentials.token,
                    :secret => auth.credentials.secret
  end

  private

  def token_data
    {
      :client_id => AppConfig.google_client,
      :client_secret => AppConfig.google_secret,
      :refresh_token => refresh_token,
      :grant_type => "refresh_token"
    }
  end
end
