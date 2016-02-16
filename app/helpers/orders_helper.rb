module OrdersHelper

	def render_order_state(order)
		t("orders.order_state.#{order.aasm_state}")
	end

	def render_paid_or_not(order)
		if order.is_paid?
			"已付款"
		else
			"未付款"
		end
	end

end
