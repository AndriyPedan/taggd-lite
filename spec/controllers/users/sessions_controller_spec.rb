require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:auth_params) { OmniauthMacros.facebook_hash }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = auth_params
  end

  subject { delete :destroy }

  describe '#destoy' do
    it { is_expected.to have_http_status(302) }
  end
end
