class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy
	def add_pet(pet_id)
		current_item = line_items.find_by_pet_id(pet_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(:pet_id => pet_id)
		end
		current_item
	end
end
