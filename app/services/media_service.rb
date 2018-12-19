class MediaService < BaseService
  CAROUSEL_ALBUM = 'CAROUSEL_ALBUM'

  def facebook_media_hash # rubocop:disable Metrics/AbcSize
    FacebookService.new(token).media(business_id).delete_if do |el|
      el['children']['data'].delete_if { |cd| persisted_media_ids.include?(cd['id']) } if el['media_type'] == CAROUSEL_ALBUM
      persisted_media_ids.include?(el['id'])
    end
  end

  def create_media_collection
    media_collection.each do |media_string|
      media_item = JSON.parse(media_string)
      type = media_type(media_item['media_type'])
      media = type.from_hash(media_item.merge({ status: status }.stringify_keys))
      media.retailer = current_retailer
      media.save
    end
  end

  def build_media
    media_item = media_type(media[:media_type]).from_hash(media.merge(status: status))
    media_item.retailer = current_retailer
    media_item
  end

  private

  def media_type(type)
    type.downcase.camelcase.constantize
  end

  def persisted_media_ids
    Media.pluck(:instagram_id)
  end
end
