class Admin::OrdersController < AdminController

	def index
		@orders = Order.order("id DESC")
	end	
end