class CartItemsController < ApplicationController
	before_action :authenticate_user!

	def destroy
		@item = current_cart.find_cart_item(params[:id])
		@product = @item.product
		@item.destroy
		flash[:success] = "已刪除#{@product.title}"
		redirect_to :back
	end

	def update
		@item = current_cart.find_cart_item(params[:id])
		if @item.product.quantity >= item_params[:quantity].to_i
			@item.update(item_params)
			flash[:success] = "成功變更數量"
		else
			flash[:notice] = "數量不足以加入購物車！"
		end
		redirect_to carts_path
	end

private

	def item_params
		params.require(:cart_item).permit(:quantity)
	end

end
