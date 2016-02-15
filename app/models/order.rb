class Order < ActiveRecord::Base
	belongs_to :user
	has_one :info, class_name: "OrderInfo", dependent: :destroy
	has_many :items, class_name: "OrderItem", dependent: :destroy
	accepts_nested_attributes_for :info

	def build_item_from_cart(cart)
		cart.items.each do |product|
			item = items.build #order_item.build
			item.product_name = product.title
			item.quantity = product.quantity
			iten.price = product.price
			item.save
		end
	end

	def calculate_total!(cart)
		self.total = cart.total_price
		self.save
	end
end
