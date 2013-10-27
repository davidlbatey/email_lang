class Account < ActiveRecord::Base
  belongs_to :user

  def action! message
    if provider == "pocket"
      pocket message
    elsif provider == "readability"
      readability message
    elsif provider == "youtube"
      youtube message
    elsif provider == "vimeo"
      vimeo message
    end

    notify message
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

    response = client.videos_by(:query => search, :page => 1, :per_page => 1)

    video_id = response.videos.first.video_id

    client.add_video_to_watchlater(video_id)
  end

  def vimeo query
    client = Vimeo::Advanced::Video.new(AppConfig.vimeo_key,
                                        AppConfig.vimeo_secret,
                                        token: account.token,
                                        secret: account.secret)

    results = client.search(query, {:page => "1",
                                    :per_page => "1",
                                    :sort => "relevance"})

    video_id = results["videos"]["video"][0]["id"]

    albums = Vimeo::Advanced::Album.new(AppConfig.vimeo_key,
                                        AppConfig.vimeo_secret,
                                        token: account.token,
                                        secret: account.secret)
    albums.add_to_watch_later(video_id)
  end

  private

  def notify url
    puts "Adding #{url} to #{provider}"
  end
end
