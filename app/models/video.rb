class Video < Media
  def self.from_hash(hash)
    new(
      status: hash['status'],
      media_url: hash['media_url'],
      thumbnail_url: hash['thumbnail_url'],
      caption: hash['caption'],
      created_time: hash['timestamp'],
      permalink: hash['permalink'],
      username: hash['username'],
      instagram_id: hash['id']
    )
  end
end
