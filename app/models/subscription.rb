class Subscription < ApplicationRecord
  belongs_to :retailer

  enum plan_type: %i[essentials complete enterprise]
end
