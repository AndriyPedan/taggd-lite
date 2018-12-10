FactoryBot.define do
  factory :subscription do
    plan_token { Faker::Internet.password(12) }
    plan_type { %w(essentials complete enterprise).sample }
    active { false }
  end
end
