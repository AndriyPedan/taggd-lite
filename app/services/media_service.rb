class MediaService < BaseService
  CAROUSEL_ALBUM = 'CAROUSEL_ALBUM'

  def facebook_media_hash # rubocop:disable Metrics/AbcSize
    FacebookService.new(token).media(business_id).delete_if do |el|
      el['children']['data'].delete_if { |cd| persisted_media_ids.include?(cd['id']) } if el['media_type'] == CAROUSEL_ALBUM
      persisted_media_ids.include?(el['id'])
    end
  end

  private

  def persisted_media_ids
    Media.pluck(:instagram_id)
  end
end
