class Dashboard::InstagramMediaController < ApplicationController
  def index
    @media = MediaService.new(token: facebook_token, business_id: business_id).facebook_media_hash
  end

  def create
    @media = build_media
    @media.retailer = current_retailer
    if @media.save
      redirect_to dashboard_media_index_path(status: @media.status), notice: 'Media was successfully saved.'
    else
      redirect_to dashboard_instagram_media_path, alert: 'Something went wrong'
    end
  end

  def batch_action
    if params[:media_collection].nil?
      redirect_to(dashboard_instagram_media_path, alert: 'Something went wrong')
    else
      accept if params['commit'] == 'Accept selected'
      reject if params['commit'] == 'Reject selected'
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

  def accept
    build_media_collection(:active)
    redirect_to dashboard_media_index_path(status: :active), notice: 'Media were successfully saved.'
  end

  def reject
    build_media_collection(:rejected)
    redirect_to dashboard_media_index_path(status: :rejected), notice: 'Media were successfully rejected.'
  end

  def build_media_collection(status)
    params[:media_collection].each do |media_string|
      media_item = JSON.parse(media_string.gsub('=>', ':'))
      type = media_item['media_type'].downcase.camelcase.constantize
      media = type.from_hash(media_item.merge({ status: status }.stringify_keys))
      media.retailer = current_retailer
      media.save
    end
  end
end
