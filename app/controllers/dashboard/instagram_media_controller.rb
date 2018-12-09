class Dashboard::InstagramMediaController < ApplicationController
  # skip_before_action :verify_user_steps!

  def index
    @media = FacebookService.new(current_user.token).media(current_user.current_retailer.business_id)
  end

  def create
    @media = build_media
    if @media.save
      redirect_to dashboard_media_index_path(status: @media.status), notice: "#{@media.type.humanize} was successfully saved."
    else
      render :new
    end
  end

  private

  def build_media
    media_type.from_hash(params[:media].merge(status: params[:status]))
  end

  def media_type
    params[:media][:media_type].downcase.camelcase.constantize
  end
end
