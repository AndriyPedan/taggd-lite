class Image < Media
  def self.from_hash(hash)
    new(
      status: hash['status'],
      media_url: hash['media_url'],
      caption: hash['caption'],
      created_time: hash['timestamp'],
      permalink: hash['permalink'],
      username: hash['username'],
      instagram_id: hash['id'],
      media_type: hash['media_type']
    )
  end
end
