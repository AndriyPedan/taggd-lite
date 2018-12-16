module FeatureHelper
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
  end

  def login_with(provider, options = { success: true })
    OmniAuth.config.mock_auth[provider] = if options[:success]
                                            OmniAuth::AuthHash.new(provider: provider, uid: '12345',
                                                                   info: { email: 'test@example.com' },
                                                                   credentials: { token: :token, secret: :secret })
                                          else
                                            :invalid_credentials
                                          end
  end
end
