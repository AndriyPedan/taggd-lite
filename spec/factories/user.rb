require 'faker'

FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.safe_email }
  end
end
