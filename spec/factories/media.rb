FactoryBot.define do
  factory :media, class: 'Media' do
    type { 'Image' }
    media_url { FFaker::Image.url }
    thumbnail_url { FFaker::Image.url }
    caption { FFaker::HipsterIpsum.word }
    username { FFaker::Internet.user_name }
    instagram_id { FFaker::IdentificationBR.cnpj }
    retailer
  end

  factory :image, parent: :media, class: 'Image' do
  end
end
