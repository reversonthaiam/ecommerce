class ProductsController < ApplicationController
  include AdminAuthenticable
  skip_before_action :require_admin!, only: [ :index, :show ]

  # def index
  #   products = Product.all
  #   render json: products
  # end

  # def show
  #   product = Product.find(params[:id])
  #   render json: product
  # end


  def index
    products = Product.all.map do |product|
      product.as_json.merge(
        image_url: product.image.attached? ? url_for(product.image) : nil
      )
    end
    render json: products
  end

  def show
    product = Product.find(params[:id])
    render json: product.as_json.merge(
      image_url: product.image.attached? ? url_for(product.image) : nil
    )
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render json: product, status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])

    if product.destroy
      render json: { message: "Product was deleted" }, status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :stock, :category_id, :image)
  end
end
