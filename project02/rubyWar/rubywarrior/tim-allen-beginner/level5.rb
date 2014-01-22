class Player
  def play_turn(warrior)
		if warrior.health < getHealth #we are taking damage
			if warrior.feel.empty?
							warrior.walk!
			else
							if warrior.feel.captive?
											warrior.rescue!
							else
								warrior.attack!
							end
			end
		else
						if warrior.health <= 12
										warrior.rest!
						elsif warrior.feel.empty?
										warrior.walk!
						elsif warrior.feel.captive?
										warrior.rescue!
						else
										warrior.attack!
						end
		end
		@health = warrior.health
  end
	def getHealth()
					if @health == nil
									return 20
					else
						return @health
					end
	end
end
