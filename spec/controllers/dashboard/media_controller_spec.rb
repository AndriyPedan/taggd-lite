require 'rails_helper'

RSpec.describe Dashboard::MediaController, type: :controller do
  let(:params) { { status: 'active' } }
  let(:media) { create(:image, status: :active) }

  describe 'GET index' do
    before do
      get :index, params: params
    end

    it 'assigns @media' do
      expect(assigns(:media)).to eq([media])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
