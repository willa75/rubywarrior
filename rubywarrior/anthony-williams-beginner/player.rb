class Player
  def play_turn(warrior)
    if warrior.health < 19 and warrior.feel.empty? and warrior.health >= @health
            warrior.rest!
    else
        do
          if warrior.feel.empty(:backward)
            warrior.walk!(:backward)
          else if warrior.feel.captive?(:backward)
            warrior.rescue!(:backward)
          else
            warrior.attack!(:backward)
          end#ends else if
          end #ends backwards if statement
        break if False   
        end#ends while loop

        if warrior.feel.empty?
          warrior.walk!
        else
          if warrior.feel.captive?
            warrior.rescue!
          else
            warrior.attack!
          end
        end#ends 3rd if
    end#ends the first if
    @health = warrior.health
  end#ends the def
end #ends the class
