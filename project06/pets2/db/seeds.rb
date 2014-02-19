# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Pet.delete_all

Pet.create!(
	:name => "Ekans",
	:age => 4,
	:primaryType => "poison",
	:secondaryType => "none",
	:image => "/img/ekans.png"
	:status => "available"
)

Pet.create!(
	:name => "Teto",
	:age => "74",
	:primaryType => "normal",
	:secondaryType => "awesome",
	:image => "/img/eevee.jpg"
	:status => "available"

)

Pet.create!(
	:name => "Entei",
	:age => "42",
	:primaryType => "fire",
	:secondaryType => "none",
	:image => "/img/splashing.jpg"
	:status => "available"
)
