class Dashboard::MediaController < ApplicationController
  def index
    @media = Media.where(status: params[:status])
  end
end
