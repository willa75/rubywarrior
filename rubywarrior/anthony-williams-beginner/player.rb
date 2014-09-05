class Player
  def play_turn(warrior)
    healer(warrior)

  end #end def play_turn

  def healer(warrior)
    if warrior.health < 14 && warrior.feel.empty? && warrior.health >= @health && warrior.look[2].to_s != "Wizard" #if warrior has taken damage, isn't around an enemy, and isn't taking damage then he uses heal
      warrior.rest!
    elsif warrior.health < 4 && warrior.look[2].to_s != "Archer" && warrior.feel(:backward).wall? == false #if warrior takes too much damage then retreat to safety
      warrior.walk!(:backward)
    elsif warrior.look(:backward)[1].to_s == "Archer" or warrior.look(:backward)[2].to_s == "Archer"
      warrior.shoot!(:backward)
    elsif warrior.look(:backward)[1].to_s == "Thick Sludge" && warrior.look[1].to_s != "Captive"
      warrior.pivot!
    else
      if warrior.feel.wall? or @forward != 1 && warrior.feel(:backward).wall? != true #if warrior runs into wall or hasn't tried to go back yet turn around
        warrior.pivot!
        @forward = 1
        $forward = 1
      elsif
        range(warrior)
      end #ends inner-if
    end #ends if
    if warrior.look(:backward)[1].to_s == "wall"
       @forward = 1
    end #ends the 2nd if
    @health = warrior.health
  end #ends def healer

  def range(warrior)
    if warrior.look[0].to_s == "nothing" && warrior.look[1].to_s == "nothing" && warrior.look[2].to_s != "Wizard"
      backcheck(warrior)
    elsif warrior.look[1].to_s == "Wizard" && warrior.look[0].to_s != "Captive"
      warrior.shoot!
    elsif warrior.look[0].to_s != "Captive" && warrior.look[1].to_s != "Captive" && warrior.look[2].to_s == "Wizard" && warrior.look[0].to_s != "Thick Sludge"
      warrior.shoot!
    elsif warrior.look[2].to_s == "Archer" && warrior.look[1].to_s == "Thick Sludge"
      warrior.shoot!
    elsif warrior.look[2].to_s == "Archer" && warrior.look[1].to_s == "Archer"
      warrior.shoot!
    else
      backcheck(warrior)
    end #end if
  end #end def


  def backcheck(warrior) #makes warrior check behind him for enemies and allies before continuing forward
    if warrior.feel(:backward).wall? == false && $forward != 1 &&
      if warrior.feel(:backward).empty?
        warrior.walk!(:backward)
      elsif warrior.feel(:backward).captive?
        warrior.rescue!(:backward)
      end #ends inner-if
    elsif warrior.look[2].to_s == "Archer" && warrior.health < 10
      warrior.walk!(:backward)
    else
        forward_move(warrior)
    end #ends outer-if
  end #ends def backcheck

  def forward_move(warrior)
    if warrior.feel(:backward).wall? == true or $forward == 1 #if warrior has reached the back or has already started moving forward
      $forward = 1
      if warrior.feel.empty?
        warrior.walk!
      elsif warrior.feel.captive?
        warrior.rescue!
      else
        warrior.attack!
      end #ends inner-if
    end #ends if
  end #ends def forward_move

end #ends class Player
