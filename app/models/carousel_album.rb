class CarouselAlbum < Media
  def self.from_hash(hash)
    new(
      status: hash['status'],
      media_url: hash['carousel_item']['media_url'],
      caption: hash['caption'],
      created_time: hash['timestamp'],
      permalink: hash['permalink'],
      username: hash['username'],
      instagram_id: hash['carousel_item']['id'],
      media_type: hash['carousel_item']['media_type']
    )
  end
end
