class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy
	def add_pet(pet_id)
		current_pet = line_items.find_by_pet_id(pet_id)
		if current_pet
			current_pet
		else
			current_pet = line_items.build(:pet_id => pet_id)
		end
	end

end
