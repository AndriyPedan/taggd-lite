require 'rails_helper'

RSpec.describe AfterSignupController, type: :controller do
  let!(:user) { create(:user) }

  subject { response }

  before { sign_in user }

  describe '#show' do
    before do
      allow_any_instance_of(RetailerService).to receive(:build_retailers) { 'business_accounts' }
      allow(Pin::Plan).to receive(:all) { [] }
      get :show, params: { id: step }
    end

    context 'business account step' do
      let(:step) { :business_account }

      it { is_expected.to have_http_status(:success) }
    end

    context 'subscription plan' do
      let(:step) { :subscription_plan }

      it { is_expected.to have_http_status(:success) }
    end
  end

  describe '#update' do
    let(:default_params) { { id: step } }
    let(:params) { default_params }
    before do
      allow_any_instance_of(RetailerService).to receive(:set_retailer) { 'set_retailer' }
      put :update, params: params
    end

    context 'business account step' do
      let(:step) { :business_account }
      let(:params) { default_params.merge(user: { retailer: { business_id: '1234' } }) }

      it { is_expected.to have_http_status(302) }
    end

    context 'subscription plan' do
      let(:step) { :subscription_plan }
      let!(:retailer) { create(:retailer, user: user, current: true) }
      let(:params) { default_params.merge(user: { current_retailer_attributes: retailer.attributes }) }

      it { is_expected.to have_http_status(302) }
    end
  end
end
