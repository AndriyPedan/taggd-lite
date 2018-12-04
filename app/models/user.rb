class User < ApplicationRecord
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
end
