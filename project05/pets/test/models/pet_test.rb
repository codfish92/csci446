require 'test_helper'

class PetTest < ActiveSupport::TestCase
	test "pet attributes must not be empty" do
		product = Pet.new
		assert product.invalid?
		assert product.errors[:name].any?
		assert product.errors[:age].any?
		assert product.errors[:primaryType].any?
		assert product.errors[:secondaryType].any?
	end

def newPet(type, primaryOrSecondary)
	if primaryOrSecondary == 0 #do primary type
		Pet.new(:name => "test",
			:age => 9001,
			:primaryType => type,
			:secondaryType => "none",
			:image => "/img/splashing.jpg")
	else
		Pet.new(:name => "test",
			:age => 9001,
			:primaryType => "fire",
			:secondaryType => type,
			:image => "/img/splashing.jpg")
	end


end

	test "pet primary type must have valid values" do
		good = %w{fire water grass electric poison ground rock ice psychic ghost dark fighting bug steel dragon}
		bad = %w{whateverTypeIWantFoo, bad, farie}
		good.each do |type|
			assert newPet(type, 0).valid?, "#{type} is not valid"
		end
		bad.each do |type|
			assert newPet(type, 0).invalid?
		end
	end

	test "pet secondary type must have valid values" do
		good = %w{none awesome fire water grass electric poison ground rock ice psychic ghost dark fighting bug steel dragon}
		bad = %w{whateverTypeIWantFoo, bad, farie}
		good.each do |type|
			assert newPet(type, 1).valid?, "#{type} is not valid"
		end
		bad.each do |type|
			assert newPet(type, 1).invalid?
		end
	end
		
end
