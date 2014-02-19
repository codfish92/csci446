class FosterParent < ActiveRecord::Base
	validates :name, :address, :email, :pet_id, :presence => true
end
