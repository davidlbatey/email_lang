class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :pocket]

  has_many :contacts
  has_many :accounts

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
                          token: access_token.credentials.token
                        )
    end

    user
  end

  def add_pocket auth
    accounts.create :action => "read",
                    :provider => "pocket",
                    :token => auth.credentials.token
  end
end
