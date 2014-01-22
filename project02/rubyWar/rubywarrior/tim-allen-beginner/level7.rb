class Player
  def play_turn(warrior)
	if warrior.health < self.getHealth()  #warrior is taking damage
		if warrior.health < 10
			warrior.walk!(:backward)
			
		elsif warrior.feel.empty?
			warrior.walk!
		else
			if warrior.feel.captive?
				warrior.rescue!
			else
				warrior.attack!
			end
		end
	else
		if warrior.health < 20
			warrior.rest!
		else 
			if warrior.feel.wall? #im at the wall
				warrior.pivot!
			else
				if warrior.feel.captive?
					warrior.rescue!
				elsif warrior.feel.empty?
					warrior.walk!
				else
					warrior.attack!
				end
			end
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

  def hitBackWall()
	  if @backwall == nil
		  return false
	  else
		  if @backwall == false
			  return false
		  else
			  return true
		  end
	  end
  end

end
