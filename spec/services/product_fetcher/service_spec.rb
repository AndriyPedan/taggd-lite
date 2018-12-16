require 'rails_helper'

RSpec.describe ProductFetcher::Service do
  let(:retailer) { create(:retailer) }
  let(:response) { double(parsed_response: parsed_response) }
  let(:name) { FFaker::Product.product_name }
  let(:description) { FFaker::Product.product }
  let(:url) { FFaker::Internet.http_url }
  let(:image) { FFaker::Image.url }
  let(:currency) { FFaker::Currency.code }
  let(:price) { '10.00' }
  let(:original_price) { '14.99' }
  let(:parsed_response) do
    "<meta property='og:title' content='#{name}'>
     <meta property='og:description' content='#{description}'>
     <meta property='og:price:amount' content='#{price}'>
     <meta property='product:original_price:amount' content='#{original_price}'>
     <meta property='og:image' content='#{image}'>
     <meta property='og:url' content='#{url}'>
     <meta property='product:price:currency' content='#{currency}'>"
  end

  subject { described_class.new(url, retailer).parse }

  describe '#parse' do
    before { allow(HTTParty).to receive(:get).and_return(response) }

    it { is_expected.not_to be_empty }
    it { expect(subject[:name]).to eq(name) }
    it { expect(subject[:description]).to eq(description) }
    it { expect(subject[:canonical_url]).to eq(url) }
    it { expect(subject[:image_url]).to eq(image) }
    it { expect(subject[:currency]).to eq(currency) }
    it { expect(subject[:price]).to eq(price) }
    it { expect(subject[:original_price]).to eq(original_price) }
  end
end
