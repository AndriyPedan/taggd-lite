class Dashboard::ProductsController < ApplicationController
  def new
    @product = media.products.new
    fetch_product if provider_url
  end

  def create
    @product = media.products.new(product_params)
    @product.save
    render :create, layout: false
  end

  def destroy
    Product.find(params[:id]).destroy
    render :destroy, layout: false
  end

  private

  def fetch_product
    attrs = ProductFetcher::Service.new(provider_url, current_user.current_retailer).parse
    @product.assign_attributes(attrs)
  end

  def provider_url
    params[:product]&.[](:provider_url)
  end

  def media
    @media ||= Media.find(params[:media_id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :original_price, :currency, :image_url, :canonical_url, :brand, :gender, category_ids: [])
  end
end
