class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
    @counter = increment_index_access_count
  end

  private

  def increment_index_access_count
    session[:counter] ||= 0
    session[:counter] +=  1
  end
end
