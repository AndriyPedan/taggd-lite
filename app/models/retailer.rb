class Retailer < ApplicationRecord
  belongs_to :user
  has_one :subscription, dependent: :destroy

  accepts_nested_attributes_for :subscription
end
