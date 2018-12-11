class FacebookService
  ACCOUNT_FIELDS = 'name,access_token,instagram_business_account{website,username,name}'.freeze
  MEDIA_FIELDS = 'caption,like_count,media_url,media_type,ig_id,permalink,thumbnail_url,timestamp,username,children{media_url,media_type,thumbnail_url}&limit=all'.freeze

  attr_reader :access_token

  class << self
    def fbgraph(token)
      Koala::Facebook::API.new(token)
    end

    def get_object(token, id, args = {}, options = {}, &block)
      fbgraph(token).get_object(id, args, options, &block)
    end
  end

  def initialize(access_token)
    @access_token = access_token
  end

  def accounts
    self.class.get_object(access_token, '/me/accounts', fields: ACCOUNT_FIELDS)
  end

  def business_accounts
    accounts.inject([]) do |res, account|
      next res unless account.key?('instagram_business_account')

      res.push(account['instagram_business_account'].merge('token' => account['access_token']))
    end
  end

  def media(instagram_id)
    self.class.get_object(access_token, "#{instagram_id}/media?fields=#{MEDIA_FIELDS}")
  end

  def mentioned_media(instagram_id, media_id)
    self.class.get_object(access_token,
                          "#{instagram_id}?fields=mentioned_media.media_id(#{media_id}){caption,username,permalink,like_count,media_type,media_url}")
  end
end
