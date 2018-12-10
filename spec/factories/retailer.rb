FactoryBot.define do
  factory :retailer do
    name { FFaker::Name.name }
    username { FFaker::Internet.username }
    business_id { FFaker::IdentificationBR.cnpj }
    token { FFaker::IdentificationBR.cnpj }
  end
end
