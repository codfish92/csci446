class CombineItemsInCart < ActiveRecord::Migration
  def change
  end
  def self.up
	  Cart.all.each do |cart|
		  sums = cart.line_items.group(:pet_id).sum(:quantity)

		  sums.each do |pet_id, quantity|
			  if quantity > 1
				  cart.line_items.where(:pet_id=>pet_id).delete_all
				  cart.line_items.create(:pet_id=>pet_id, :quantity=>quantity)
			  end
		  end
	  end
  end
  def self.down
	  LineItem.where("quantity>1").each do |line_item|
		  line_item.quantity.times do 
			  LineItem.create :cart_id=>line_item.cart_id, :pet_id=>line_item.pet_it, :quantit=>1
		  end
		  line_item.destroy
	  end
  end

end
