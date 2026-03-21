class OrderService
  def self.create(current_user, params)
    order = Order.create(user_id: current_user.id, status: "pendente", total: 0)

    params[:items].each do |item|
      product = Product.find(item[:product_id])

      OrderItem.create(
        order_id: order.id,
        product_id: product.id,
        quantity: item[:quantity],
        unit_price: product.price
      )
    end

    total = order.order_items.sum { |i| i.quantity * i.unit_price }
    order.update(total: total)

    OrderConfirmationJob.perform_later(order.id)

    { success: true, order: order }
  end
end
