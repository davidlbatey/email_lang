class Account < ActiveRecord::Base
  belongs_to :user

  def action! message
    if provider == "pocket"
      pocket message
    elsif provider == "readability"
      readability message
    elsif provider == "youtube"
      youtube message
    end

    notify url
  end

  def pocket url
    client = Pocket.client(:access_token => token)
    client.add :url => url
  end

  def readability url
    client = Readit::API.new token, secret
    client.bookmark :url => url
  end

  def youtube search
    client = YouTubeIt::OAuth2Client.new(client_access_token: user.token,
                                         client_id: AppConfig.google_client,
                                         client_secret: AppConfig.google_secret,
                                         dev_key: AppConfig.youtube_key)

    videos = client.videos_by(:query => search, :page => 1, :per_page => 1)

    video_id = response.videos.first.video_id

    client.add_video_to_watchlater(video_id)
  end

  private

  def notify url
    puts "Adding #{url} to #{provider}"
  end
end
