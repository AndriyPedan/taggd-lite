class SubscriptionsController < ApplicationController
  skip_before_action :verify_user_steps!

  def create
    errors = SubscriptionService.new(current_user, params).subscribe

    render json: { errors: errors, url: after_signup_path(:finish) }
  end
end
