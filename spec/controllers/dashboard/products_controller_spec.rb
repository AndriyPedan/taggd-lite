require 'rails_helper'

RSpec.describe Dashboard::ProductsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:retailer) { create(:retailer, user: user) }
  let!(:subscription) { create(:subscription, active: true, retailer: retailer) }
  let(:media) { create(:media) }
  let(:product) { create(:product, media: media) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET new' do
    context 'without url' do
      before { get :new, params: { media_id: media.id } }

      it { expect(assigns(:product).media_id).to eq(media.id) }
      it { expect(response).to have_http_status(200) }
    end

    context 'with url' do
      let(:product_params) { { name: 'name' } }

      before do
        allow(HTTParty).to receive(:get).and_return(double(parsed_response: ''))
        allow_any_instance_of(ProductFetcher::Service).to receive(:parse).and_return(product_params)
        get :new, params: { media_id: media.id, product: { provider_url: 'url' } }
      end

      it { expect(assigns(:product).name).to eq('name') }
      it { expect(response).to have_http_status(200) }
    end
  end

  describe 'POST create' do
    let(:product_params) { { name: 'name', price: 1, currency: 'USD' } }

    before { post :create, params: { media_id: media.id, product: product_params }, xhr: true }

    it { expect(media.products.count).to eq(1) }
    it { expect(assigns(:product).name).to eq(product_params[:name]) }
    it { expect(assigns(:product).price.to_i).to eq(product_params[:price]) }
    it { expect(assigns(:product).currency).to eq(product_params[:currency]) }
    it { expect(response).to have_http_status(200) }
  end

  describe 'DELETE destroy' do
    let!(:product) { create(:product, media: media) }

    before { delete :destroy, params: { media_id: media.id, id: product.id }, xhr: true }


    it { expect(media.products.count).to eq(0) }
    it { expect(response).to have_http_status(200) }
  end
end
