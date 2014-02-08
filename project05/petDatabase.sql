create table pets{
	id integer primary key unique,
	id integer age,
	id text name,
	id text primaryType,
	id text secondaryType,
	id text fostered	
};


	validates :primaryType, inclusion: { in: %w("poison", "fire", "water", "electric", "grass", "rock", "ground", "psychic", "ice", "flying", "dragon", "fighting", "ghost", "normal", "steel", "dark", "bug"), 
					    message: "%(value) is not a valid type"}
