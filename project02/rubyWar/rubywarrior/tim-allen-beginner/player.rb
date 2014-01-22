class Player
  def play_turn(warrior)
	thingsAhead = warrior.look.to_s
	if warrior.health < self.getHealth()  #warrior is taking damage
		if warrior.health < 10
			warrior.walk!(:backward)
			
		else
			if warrior.feel.captive?
				warrior.rescue!
			else
				warrior.shoot!
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
				elsif self.determineAction(warrior) == "walk"
					warrior.walk!
				elsif self.determineAction(warrior) == "attack"
					warrior.shoot!
				elsif self.determineAction(warrior) == "rescue"
					warrior.walk!
				elsif self.determineAction(warrior) == "turnAround"
					warrior.pivot!
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
  def determineAction(warrior)
	  i = 0
	  while i < 3
		  if warrior.look(:backward)[i].to_s.include?("nothing") or warrior.look(:backward)[i].to_s.include?("wall")
			  i += 1
		  elsif i == 0 and warrior.look(:backward)[i].to_s.include?("Thick Sludge")
			  return "turnAround"
	  	  elsif warrior.look(:backward)[i].to_s.include?("Wizard") or warrior.look(:backward)[i].to_s.include?("Archer")
			  return "turnAround"
		  elsif warrior.look(:backward)[i].to_s.include?("Thick Sludge") or warrior.look(:backward)[i].to_s.include?("Captive")
			  i = 3
	  	  end
	  end
	  i = 0
	  while i < 3
		  if warrior.look[i].to_s.include?("nothing") or warrior.look[i].to_s.include?("wall")
			  i += 1
		  elsif warrior.look[i].to_s.include?("Captive")
			  return "rescue"
		  elsif warrior.look[i].to_s.include?("Wizard") or warrior.look[i].to_s.include?("Archer") or warrior.look[i].to_s.include?("Thick Sludge") or warrior.look[i].to_s.include?("Sludge")
			  return "attack"
		  else
			  return "walk"
		  end
	 end
	 return "walk"
  end

end
