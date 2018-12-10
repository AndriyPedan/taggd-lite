require 'rails_helper'

RSpec.describe SubscriptionService do
  let!(:user) { create(:user) }
  let!(:retailer) { create(:retailer, user: user) }
  let!(:subscription) { create(:subscription, retailer: retailer) }
  let(:params) { { email: user.email, card_token: 'card_token' } }
  let(:pin_response) do
    { token: 'cus_token', card: { token: 'card_token' }.stringify_keys }.stringify_keys
  end

  subject { described_class.new(user, params).subscribe }

  describe '#subscribe' do
    before do
      allow(Pin::Customer).to receive(:update).and_return(pin_response)
      allow(Pin::Customer).to receive(:create).and_return(pin_response)
    end

    context 'sufficient founds' do
      before do
        allow(Pin::Subscription).to receive(:create).and_return(pin_response)
        subject
      end

      context 'no customer token' do
        it { is_expected.to be_empty }
        it { expect(subscription.reload.customer_token).to eq(pin_response['token']) }
        it { expect(subscription.reload.subscription_token).to eq(pin_response['token']) }
        it { expect(subscription.reload.card_token).to eq(params[:card_token]) }
      end

      context 'customer token exists' do
        let!(:subscription) { create(:subscription, customer_token: '123', retailer: retailer) }

        it { is_expected.to be_empty }
        it { expect(subscription.reload.subscription_token).to eq(pin_response['token']) }
        it { expect(subscription.reload.card_token).to eq(params[:card_token]) }
      end
    end

    context 'insufficient founds' do
      before do
        allow(Pin::Subscription).to receive(:create)
          .and_raise(Pin::ChargeError.new({ error_description: 'insufficient_founds' }.stringify_keys))
        subject
      end

      it { is_expected.to eq(['insufficient_founds']) }
      it { expect(subscription.reload.subscription_token).to be_nil }
      it { expect(subscription.reload.card_token).to be_nil }
    end
  end
end
