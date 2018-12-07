class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :retailers, dependent: :destroy
  has_one :current_retailer, -> { where(current: true) }, class_name: 'Retailer'
  has_one :subscription, through: :current_retailer

  after_commit :update_business_accounts

  accepts_nested_attributes_for :retailers

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
end
