class AfterSignupController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_user_steps!
  include Wicked::Wizard

  steps :business_account, :subscription_plan, :card_addition

  def show
    @user = current_user
    case step
    when :business_account
      @retailers = build_retailers
    when :subscription_plan
      @plans ||= Pin::Plan.all.sort { |plan| plan['amount'].to_i }
    when :card_addition
    end

    render_wizard
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    render_wizard @user
  end

  private

  def redirect_to_finish_wizard(_options, _params)
    redirect_to root_path, notice: 'Thank you for signing up.'
  end

  # TODO:
  # Accept nested attributes
  def user_params
    params.require(:user).permit(:email)
  end

  def build_retailers
    FacebookService.new(current_user.token).business_accounts.map do |business_account|
      current_user.retailers.new(
        username: business_account['username'],
        name: business_account['name'],
        business_id: business_account['id'],
        token: business_account['token']
      )
    end
  end
end
