FactoryBot.define do
  factory :retailer do
    name { FFaker::Name.name }
    username { FFaker::Internet.user_name }
    business_id { FFaker::IdentificationBR.cnpj }
    token { FFaker::IdentificationBR.cnpj }
    current { true }
  end
end
