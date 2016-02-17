class OrderPlacingService

	def initialize(order, cart)
		@order = order
		@cart = cart
	end

	def order_placed
		@order.build_item_from_cart(@cart)
		@order.calculate_total!(@cart)
		@cart.clean!
		OrderMailer.notify_order_placed(@order).deliver!
	end

end


