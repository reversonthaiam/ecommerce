class OrderConfirmationJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    order.update(status: "Done")
    OrderMailer.confirmation(order).deliver_now
  end
end
