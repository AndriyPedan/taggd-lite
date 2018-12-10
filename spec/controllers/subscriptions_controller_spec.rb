require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { create(:user) }
  let(:expected_url) { '/after_signup/finish' }
  let(:params) { { email: user.email, card_token: 'token' } }

  subject { post :create, params: params }

  describe '#create' do
    before { allow(controller).to receive(:current_user).and_return(user) }

    context 'no errors' do
      before { allow_any_instance_of(SubscriptionService).to receive(:subscribe).and_return([]) }

      it { is_expected.to have_http_status(:ok) }
      it { expect(JSON.parse(subject.body)['errors']).to be_empty }
      it { expect(JSON.parse(subject.body)['url']).to eq(expected_url) }
    end

    context 'with errors' do
      before { allow_any_instance_of(SubscriptionService).to receive(:subscribe).and_return(['error']) }

      it { is_expected.to have_http_status(:ok) }
      it { expect(JSON.parse(subject.body)['errors']).not_to be_empty }
      it { expect(JSON.parse(subject.body)['url']).to eq(expected_url) }
    end
  end
end
