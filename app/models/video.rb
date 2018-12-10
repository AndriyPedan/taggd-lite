class Video < Media
  def self.from_hash(hash) # rubocop:disable Metrics/MethodLength
    new(
      status: hash['status'],
      media_url: hash['media_url'],
      thumbnail_url: hash['thumbnail_url'],
      caption: hash['caption'],
      created_time: hash['timestamp'],
      permalink: hash['permalink'],
      username: hash['username'],
      instagram_id: hash['id'],
      media_type: hash['media_type']
    )
  end
end
