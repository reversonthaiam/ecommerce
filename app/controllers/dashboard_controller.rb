class DashboardController < ApplicationController
  def index
    total_sales_today = Rails.cache.fetch("dashboard:total_sales_today", expires_in: 2.minutes) do
      Order.where("created_at >= ?", Date.today).sum(:total)
    end

    best_selling_products = Rails.cache.fetch("dashboard:best_selling_products", expires_in: 2.minutes) do
      OrderItem.joins(:product).group("products.name").sum(:quantity)
    end

    revenue_by_category = Rails.cache.fetch("dashboard:revenue_by_category", expires_in: 2.minutes) do
      OrderItem.joins(product: :category).group("categories.name").sum("quantity * unit_price")
    end

    render json: {
      total_sales_today: total_sales_today,
      best_selling_products: best_selling_products,
      revenue_by_category: revenue_by_category
    }, status: :ok
  end
end
