class LineItem < ActiveRecord::Base
	belongs_to :pet
	belongs_to :cart
	def total_price
		pet.price * quantity
	end

end
