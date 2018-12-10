FactoryBot.define do
  factory :retailer do
    name { FFaker::Name.name }
    username { FFaker::Name.first_name }
    business_id { FFaker::IdentificationBR.cnpj }
  end
end
