class ApplicationController < ActionController::Base
  before_action :verify_user_steps!

  def active_subsciption?
    current_retailer&.subscription&.active
  end

  def current_retailer
    current_user&.current_retailer
  end

  private

  def verify_user_steps!
    return if devise_controller?

    return if active_subsciption?

    redirect_to after_signup_path(:business_account)
  end
end
