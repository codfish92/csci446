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
			if self.hitBackWall() == false # I haven't hit back wall
				if warrior.feel(:backward).captive? #is there a captive behind me
					warrior.rescue!(:backward) #resuce them
				elsif warrior.feel(:backward).empty? #is there nothing behind me
					warrior.walk!(:backward) #go backwards
				else #ive hit back wall
					@backwall = true
					warrior.walk! #go back forward
				end
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
