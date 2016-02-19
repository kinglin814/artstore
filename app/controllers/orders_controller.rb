class OrdersController < ApplicationController
	before_action :authenticate_user!, except: [:pay2go_cc_notify, :pay2go_atm]

	protect_from_forgery except: [:pay2go_cc_notify, :pay2go_atm]

	def create
		@order = current_user.orders.build(order_params)
		if @order.save
			OrderPlacingService.new(@order, current_cart).order_placed
			redirect_to order_path(@order.token)
		else
			render "carts/checkout"
		end
	end

	def show
		@order = current_user.orders.find_by_token(params[:id])
		@order_info = @order.info
		@order_items = @order.items
	end

	def pay_by_card
		@order = current_user.orders.find_by_token(params[:id])
		@order.set_payment_with!("Credit Card")
		@order.make_payment!
		redirect_to account_orders_path, notice: "成功完成信用卡付款"
	end


		def pay2go_cc_notify
		@order = Order.find_by_token(params[:id])
		if params["Status"] == "SUCCESS"    #如果傳回的訊息 true 狀態改成paid & is_paid = trueg ,method為credit card
			@order.make_payment!							#if is_paid true 轉換頁面
			@order.set_payment_with!("Credit Card")
			if @order.is_paid?
				flash[:success] = "信用卡付款成功！"
				redirect_to account_orders_path
			else
				render text: "信用卡失敗"
			end
		else
			render text: "交易失敗"
		end
	end

	def pay2go_atm
		@order = Order.find_by_token(params[:id])
		json_data = JSON.parse(params["JSONData"])
		if json_data["Status"] == "SUCCESS"
			@order.set_payment_with!("ATM")
			@order.make_payment!
			render text: "交易成功"
		else
			render text: "交易失敗"
		end
	end


	private

	def order_params
		params.require(:order).permit(info_attributes: [:billing_name, :billing_address,
																										:shipping_name, :shipping_address])
	end
end
