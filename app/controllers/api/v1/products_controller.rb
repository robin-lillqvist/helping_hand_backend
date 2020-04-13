class Api::V1::ProductsController < ApplicationController
  def index
    product = Product.all

    render json: {products: product}
  end
end
