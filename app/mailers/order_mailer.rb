class OrderMailer < ApplicationMailer
  def confirmation(order)
    @order = order
    @user = order.user

    mail(
      to: @user.email,
      subject: "Pedido ##{@order.id} confirmado!"
    )
  end
end
