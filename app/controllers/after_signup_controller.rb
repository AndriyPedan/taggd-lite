class AfterSignupController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_user!
  skip_before_action :verify_user_steps!

  steps :business_account, :subscription_plan, :card_addition, :finish

  def show
    @user = current_user
    case step
    when :business_account
      @retailers = RetailerService.new(token: current_user.token).build_retailers
    when :subscription_plan
      @plans ||= Pin::Plan.all.sort { |plan| plan['amount'].to_i }
    when :card_addition # rubocop:disable Lint/EmptyWhen
    end

    render_wizard
  end

  def update
    @user = current_user
    case step
    when :business_account
      RetailerService.new(user: current_user, params: params).set_retailer
    when :subscription_plan
      @user.assign_attributes(user_params)
    end
    render_wizard @user
  end

  private

  def redirect_to_finish_wizard(_options, _params)
    redirect_to root_path, notice: 'Thank you for signing up.'
  end

  def user_params
    params.require(:user).permit(:email, current_retailer_attributes: [:id, subscription_attributes: %i[plan_token plan_type]])
  end
end
