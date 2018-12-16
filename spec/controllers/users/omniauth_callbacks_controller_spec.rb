require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:auth_params) { OmniauthMacros.facebook_hash }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = auth_params
  end

  describe '#create_and_sign_in' do
    subject { get :facebook }

    context 'successful signup' do
      it { is_expected.to redirect_to(root_path) }
    end
  end
end
