class Order < ActiveRecord::Base
	belongs_to :user
	has_one :info, class_name: "OrderInfo", dependent: :destroy
	has_many :items, class_name: "OrderItem", dependent: :destroy
	accepts_nested_attributes_for :info

	
 include Tokenable


	def build_item_from_cart(cart)
		cart.items.each do |product|
			item = items.build #order_item.build
			item.product_name = product.title
			item.quantity = cart.find_cart_item(product).quantity
			item.price = product.price
			item.save
		end
	end

	def calculate_total!(cart)
		self.total = cart.total_price
		self.save
	end

	def set_payment_with!(method)
		self.update(payment_method: method)
	end

	def pay!
		self.update(is_paid: true)
	end

	include AASM

	aasm do 
		state :order_placed, initial: true
		state :paid
		state :shipping
		state :shipped
		state :order_canceled
		state :good_returned

		event :make_payment, after_commit: :pay! do
			transitions from: :order_placed, to: :paid
		end

		event :ship do
			transitions from: :paid, to: :shipping
		end

		event :deliver do
			transitions from: :shipping, to: :shipped
		end

		event :return_good do
			transitions from: :shipped, to: :good_returned
		end

		event :cancel_order do
			transitions from: [:order_placed, :paid], to: :order_canceled
		end

	end


end
