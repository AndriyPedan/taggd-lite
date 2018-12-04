class AfterSignupController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_user_steps!
  include Wicked::Wizard

  steps :business_account, :subscription_plan, :card_addition

  def show
    @user = current_user
    case step
    when :business_account
    when :subscription_plan
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

  def redirect_to_finish_wizard(options, params)
    redirect_to root_path, notice: 'Thank you for signing up.'
  end

  # TODO:
  # Accept nested attributes
  def user_params
    params.require(:user).permit(:email)
  end
end
