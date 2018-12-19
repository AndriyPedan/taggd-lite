require 'rails_helper'

RSpec.describe Dashboard::SettingsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:retailer) { create(:retailer, user: user) }
  let!(:subscription) { create(:subscription, active: true, retailer: retailer) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET index' do
    before { get :index }

    it { expect(response).to have_http_status(200) }
  end
end
