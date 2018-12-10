FactoryBot.define do
  factory :subscription do
    plan_token { FFaker::IdentificationBR.cnpj }
    plan_type { %w[essentials complete enterprise].sample }
    active { false }
  end
end
