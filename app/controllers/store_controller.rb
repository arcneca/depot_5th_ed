class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
      @counter = increment_index_access_count
    end
  end

  private

  def increment_index_access_count
    session[:counter] ||= 0
    session[:counter] +=  1
  end
end
