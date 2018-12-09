class MediaSevice < BaseService
  def fetch_media
    FacebookService.new(token).media(instagram_id)
  end
end