class Player
  def play_turn(warrior)
	  	if warrior.health <= 10
			warrior.rest!
		elsif warrior.feel.empty?
  		 warrior.walk!
		else
			 warrior.attack!
		end
  end
end
