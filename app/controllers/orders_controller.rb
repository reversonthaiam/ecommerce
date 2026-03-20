class OrdersController < ApplicationController
  def index
    orders = current_user.orders

    render json: orders
  end

  def show
    order = current_user.orders.find(params[:id])

    render json: order
  end

  def create
    result = OrderService.create(current_user, order_params)

    if result[:success]
      render json: result[:order], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end


  private


  def order_params
    params.require(:order).permit(items: [ :product_id, :quantity ])
  end
end
