class Account < ActiveRecord::Base
  belongs_to :user

  def action! url
    if provider == "pocket"
      pocket url
    else
      instapaper url
    end

    notify url
  end

  def pocket url
    client = Pocket.client(:access_token => token)
    client.add :url => url
  end

  def readability url
  end

  private

  def notify url
    puts "Adding #{url} to #{provider}"
  end

  def encrypt password

  end

  def decrypt password

  end
end
