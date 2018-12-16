class Dashboard::InstagramMediaController < ApplicationController
  def index
    @media = MediaService.new(token: facebook_token, business_id: business_id).facebook_media_hash
  end

  def create
    @media = build_media
    current_retailer.media << @media
    if @media.save
      redirect_to dashboard_media_index_path(status: @media.status), notice: 'Media was successfully saved.'
    else
      redirect_to dashboard_instagram_media_path, alert: 'Something went wrong'
    end
  end

  private

  def build_media
    media_type.from_hash(params[:media].merge(status: params[:status]))
  end

  def media_type
    params[:media][:media_type].downcase.camelcase.constantize
  end

  def facebook_token
    current_user.token
  end

  def business_id
    current_retailer.business_id
  end
end
