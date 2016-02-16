class CartItemsController < ApplicationController
	before_action :authenticate_user!

	def destroy
		@item = current_cart.cart_items.find_by(product_id: params[:id])
		@product = @item.product
		@item.destroy
		flash[:success] = "已刪除#{@product.title}"
		redirect_to :back
	end

	def update
		@item = current_cart.cart_items.find_by(product_id: params[:id])
		@item.update(item_params)
		redirect_to carts_path
	end

private

	def item_params
		params.require(:cart_item).permit(:quantity)
	end

end
