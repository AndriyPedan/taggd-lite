class ApplicationController < ActionController::Base
  before_action :verify_user_steps!

  private

  def verify_user_steps!
    return if devise_controller?
    # return unless user_signed_in?
    # return if current_user && current_user.retailers.present?

    redirect_to after_signup_path(:business_account)
  end
end
