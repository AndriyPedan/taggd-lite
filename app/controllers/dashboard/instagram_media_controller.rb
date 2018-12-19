class Dashboard::InstagramMediaController < ApplicationController
  def index
    @media = MediaService.new(token: facebook_token, business_id: business_id).facebook_media_hash
  end

  def create
    if params[:media_collection].nil?
      redirect_to(dashboard_instagram_media_path, alert: 'Something went wrong')
    else
      save_with_status(params[:status])
    end
  end

  private

  def facebook_token
    current_user.token
  end

  def business_id
    current_retailer.business_id
  end

  def save_with_status(status)
    MediaService.new(status: status, media_collection: params[:media_collection], current_retailer: current_retailer).create_media_collection
    redirect_to dashboard_media_index_path(status: status), notice: 'Media were successfully saved.'
  end
end
