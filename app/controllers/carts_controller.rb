class CartsController < ApplicationController
	before_action  :authenticate_user!, only: [:checkout]

	def checkout
		@order = current_user.orders.build
		@info = @order.build_info
	end

	def clean
		current_cart.clean!
		flash[:success] = "成功清空購物車！"
		redirect_to :back
	end
end
