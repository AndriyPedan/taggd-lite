class RetailerService < BaseService
  def build_retailers
    FacebookService.new(token).business_accounts.map do |account|
      account['business_id'] = account.delete 'id'
      [account['name'], account.to_json]
    end.to_h
  end

  def set_retailer
    user.retailers.update_all(current: false)
    r = user.retailers.create_with(retailer_params)
            .find_or_create_by(business_id: retailer_params['business_id'])
    r.update(current: true, token: retailer_params['token'])
  end

  private

  def retailer_params
    JSON.parse(params)
  end
end
