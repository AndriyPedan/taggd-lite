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
    let(:params) { { media: media_array.first, status: :active } }

    before do
      post :create, params: params
    end

    context 'success' do
      it 'creates media successfuly' do
        expect(response).to redirect_to(dashboard_media_index_path(status: 'active'))
      end
    end
  end

  describe 'POST bulk action' do
    let(:media_collection) do
      ['{"caption"=>"Tōto sundai", "like_count"=>3, "media_url"=>"https://scontent.xx.fbcdn.net/v/t51.2885-15/47076380_568669026930966_221561669357239164_n.jpg?_nc_cat=105&_nc_ht=scontent.xx&oh=bec05a3d20df760ca424cde71a48c78a&oe=5C8D9DD9", "media_type"=>"IMAGE","ig_id"=>"1935864350210159259", "permalink"=>"https://www.instagram.com/p/Brdkl6vnnKb/", "timestamp"=>"2018-12-16T20:43:55+0000", "username"=>"all_views_of_mount_fuji", "id"=>"17985149905190798"}',
       '{"caption"=>"Sanka hakuu", "like_count"=>2, "media_url"=>"https://scontent.xx.fbcdn.net/v/t51.2885-15/46350187_140237693631552_7162516671978591219_n.jpg?_nc_cat=110&_nc_ht=scontent.xx&oh=a769478f09632d1f38adc56659e06003&oe=5C9837AB", "media_type"=>"IMAGE", "ig_id"=>"1932915527829589953", "permalink"=>"https://www.instagram.com/p/BrTGG55Ho_B/", "timestamp"=>"2018-12-12T19:05:08+0000", "username"=>"all_views_of_mount_fuji", "id"=>"17985322240185746"}']
    end
    let(:params) { { media_collection: media_collection, commit: 'Accept selected' } }

    before do
      post :batch_action, params: params
    end

    context 'accept' do
      it 'creates media successfuly' do
        expect(response).to redirect_to(dashboard_media_index_path(status: 'active'))
      end
    end

    context 'reject' do
      let(:params) { { media_collection: media_collection, commit: 'Reject selected' } }

      it 'creates media successfuly' do
        expect(response).to redirect_to(dashboard_media_index_path(status: 'rejected'))
      end
    end

    context 'error' do
      let(:params) { {} }

      it 'nothing is created' do
        expect(response).to redirect_to(dashboard_instagram_media_path)
      end
    end
  end
end
