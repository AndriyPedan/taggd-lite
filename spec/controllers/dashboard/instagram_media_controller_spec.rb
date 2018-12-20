require 'rails_helper'

RSpec.describe Dashboard::InstagramMediaController, type: :controller do
  let(:retailer) { create(:retailer) }
  let(:media_array) do
    [{ 'like_count' => 2,
       'media_url' =>
       'https://scontent.xx.fbcdn.net/v/t51.2885-15/46411707_342343413019015_545776328708773602_n.jpg?_nc_cat=111&_nc_ht=scontent.xx&oh=ed98d35f1b2c7e406d1a93f47f8ab925&oe=5CB1F591',
       'media_type' => 'IMAGE',
       'ig_id' => '1931314175135254715',
       'permalink' => 'https://www.instagram.com/p/BrNaAJ-nQi7/',
       'timestamp' => '2018-12-10T14:03:32+0000',
       'username' => 'kidnapkintagged',
       'id' => '11111111111111' }]
  end

  before do
    allow(controller).to receive(:current_user).and_return(retailer.user)
    allow(controller).to receive(:active_subsciption?).and_return(true)
  end

  describe 'GET index' do
    before do
      allow_any_instance_of(MediaService).to receive(:facebook_media_hash).and_return(media_array)
      get :index
    end

    it 'assigns @media' do
      expect(assigns(:media)).to eq(media_array)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'POST create' do
    let(:params) { { 'media_collection[]' => media_array.first.to_json, status: :active } }

    before do
      post :create, params: params
    end

    context 'success' do
      it 'creates media successfuly' do
        expect(response).to redirect_to(dashboard_media_index_path(status: 'active'))
      end
    end
  end
end
