require 'rails_helper'

describe RetailerService do
  let(:instance) { described_class.new(params) }

  describe '#build_retailers' do
    let(:params) { { token: 'token' } }
    let(:business_accounts) do
      [{ 'username' => 'tagg._.tag',
         'name' => 'Tagg Tag',
         'id' => '17841409430992073',
         'token' => 'acount_token' }]
    end
    let(:transformed_accounts) do
      { 'Tagg Tag' => '{"username":"tagg._.tag","name":"Tagg Tag","token":"acount_token","business_id":"17841409430992073"}' }
    end

    before do
      allow_any_instance_of(FacebookService).to receive(:business_accounts) { business_accounts }
    end

    subject { instance.build_retailers }

    it { is_expected.to eq(transformed_accounts) }
  end

  describe '#set_retailer' do
    let(:user) { create(:user) }
    let!(:retailer) { create(:retailer, user: user, current: true) }
    let(:params) { { user: user, params: retailer_params } }
    let(:retailer_params) { attributes_for(:retailer).to_json }

    subject { instance.set_retailer }

    before { subject }

    it { expect(user.retailers.length).to eq(2) }
    it { expect(user.retailers.first.current).to be_falsy }
    it { expect(user.retailers.last.current).to be_truthy }
  end
end
