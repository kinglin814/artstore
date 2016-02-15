class Order < ActiveRecord::Base
	belongs_to :user
	has_one :info, class_name: "OrderInfo", dependent: :destroy
	has_many :items, class_name: "OrderItem", dependent: :destroy
	accepts_nested_attributes_for :info

	before_create :generate_token

	def generate_token
		self.token = SecureRandom.uuid
	end


	def build_item_from_cart(cart)
		cart.items.each do |product|
			item = items.build #order_item.build
			item.product_name = product.title
			item.quantity = product.quantity
			item.price = product.price
			item.save
		end
	end

	def calculate_total!(cart)
		self.total = cart.total_price
		self.save
	end
end
