class Pet < ActiveRecord::Base
	default_scope :order => "name"
	has_many :line_items
	has_many :orders, :through => :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	validates :name, :age, :primaryType, :secondaryType, :price, :presence => true
	validates :age, :price, :numericality =>{:greater_than_or_equal_to => 0}
	validates :primaryType, inclusion: { in: %w(poison fire water electric grass rock ground psychic ice flying dragon fighting ghost normal steel dark bug),
		message: "'%{value}' is not a valid primary type"}
	validates :secondaryType, inclusion: { in: %w(awesome none poison fire water electric grass rock ground psychic ice flying dragon fighting ghost normal steel dark bug), 
		message: "'%{value}' is not a valid secondary type"}



	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			error.add(:base, 'Line Items present')
			return false
		end
	end
end
