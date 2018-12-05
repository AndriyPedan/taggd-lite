class User < ApplicationRecord
  has_many :retailers

  after_commit :update_business_accounts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.token = auth.credentials.token
      user.name = auth.info.name
    end
  end

  private

  def password_required?
    false
  end

  def update_business_accounts
    FacebookService.new(token).business_accounts.each do |business_account|
      retailers.find_or_create_by(business_id: business_account['id']) do |retailer|
        retailer.update_attributes(
          username: business_account['username'],
          name: business_account['name'],
          business_id: business_account['id'],
          token: business_account['token']
        )
      end
    end
  end
end
