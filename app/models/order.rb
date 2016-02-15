class Order < ActiveRecord::Base
	belongs_to :user
	has_one :info, class_name: "OrderInfo", dependent: :destroy
	has_many :items, class_name: "OrderItem", dependent :destroy

end
