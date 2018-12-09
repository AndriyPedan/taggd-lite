class Dashboard::MediaController < ApplicationController
  # skip_before_action :verify_user_steps!

  def index
    @media = Media.where(status: params[:status])
  end
end
