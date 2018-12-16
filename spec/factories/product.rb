FactoryBot.define do
  factory :product do
    name { FFaker::Product.product_name }
    description { FFaker::Product.product }
    canonical_url { FFaker::Internet.http_url }
    image_url { FFaker::Image.url }
    currency { FFaker::Currency.code }
    price { rand(0.01..100.00) }
    original_price { rand(0.01..100.00) }
  end
end
