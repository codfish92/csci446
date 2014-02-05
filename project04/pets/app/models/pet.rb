class Pet < ActiveRecord::Base
	default_scope :order => "name"
	validates :name, :age, :primaryType, :secondaryType, :presence => true
	validates :age, :numericality =>{:greater_than_or_equal_to => 0}
	validates :primaryType, inclusion: { in: %w(poison fire water electric grass rock ground psychic ice flying dragon fighting ghost normal steel dark bug),
		message: "'%{value}' is not a valid primary type"}
	validates :secondaryType, inclusion: { in: %w(awesome none poison fire water electric grass rock ground psychic ice flying dragon fighting ghost normal steel dark bug), 
		message: "'%{value}' is not a valid secondary type"}
end
