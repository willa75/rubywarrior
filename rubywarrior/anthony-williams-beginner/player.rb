class Player
  TAKEN_DAMAGE = 14
  VERY_LOW_HEALTH = 3
  LOW_HEALTH = 4
  attr_accessor :warrior

  def play_turn(warrior)
    @warrior = warrior
    healer
  end #end def play_turn

  def healer
    if safe_to_heal?
      if low_health_with_captive_but_not_in_danger_v1?
        warrior.walk!
      elsif low_health_with_captive_but_not_in_danger_v2?
        warrior.rescue!
      elsif low_health_with_captive_but_not_in_danger_v3?
        warrior.walk!
      elsif low_health_but_no_danger_lvl6?
        warrior.walk!
      else

       warrior.rest!
     end #ends inner-if
   elsif warrior.health < LOW_HEALTH && warrior.look[2].to_s != "Archer" && warrior.feel(:backward).wall? == false #if warrior takes too much damage then retreat to safety
      if warrior.look[0].to_s == "Thick Sludge" && warrior.look[1].to_s == "Captive"
        warrior.attack!
      elsif warrior.feel.captive?
        warrior.rescue!
      else
        warrior.walk!(:backward)
      end #ends inner-if
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
        range
      end #ends inner-if
    end #ends if
    if warrior.look(:backward)[1].to_s == "wall"
       @forward = 1
    end #ends the 2nd if
    @health = warrior.health
  end #ends def healer

  def range
    if warrior.look[0].to_s == "nothing" && warrior.look[1].to_s == "nothing" && warrior.look[2].to_s != "Wizard"
      backcheck
    elsif warrior.look[1].to_s == "Wizard" && warrior.look[0].to_s != "Captive"
      warrior.shoot!
    elsif warrior.look[0].to_s != "Captive" && warrior.look[1].to_s != "Captive" && warrior.look[2].to_s == "Wizard" && warrior.look[0].to_s != "Thick Sludge"
      warrior.shoot!
    elsif warrior.look[2].to_s == "Archer" && warrior.look[1].to_s == "Thick Sludge" && warrior.look[0].to_s != "Captive"
      warrior.shoot!
    elsif warrior.look[2].to_s == "Archer" && warrior.look[1].to_s == "Archer" && warrior.look[0].to_s != "Captive"
      warrior.shoot!
    else
      backcheck
    end #end if
  end #end def


  def backcheck
    #makes warrior check behind him for enemies and allies before continuing forward
    if warrior.feel(:backward).wall? == false && $forward != 1 &&
      if warrior.feel(:backward).empty?
        warrior.walk!(:backward)
      elsif warrior.feel(:backward).captive?
        warrior.rescue!(:backward)
      end #ends inner-if
    elsif warrior.look[2].to_s == "Archer" && warrior.health < 10
      warrior.walk!(:backward)
    else
        forward_move
    end #ends outer-if
  end #ends def backcheck

  def forward_move
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

  def safe_to_heal?
    warrior.health < TAKEN_DAMAGE && warrior.feel.empty? && warrior.health >= @health && warrior.look[2].to_s != "Wizard" #if warrior has taken damage, isn't around an enemy, and isn't taking damage then he uses heal
  end

  def low_health_with_captive_but_not_in_danger_v1?
    warrior.look[1].to_s == "Captive" && warrior.look[2].to_s == "wall" && warrior.health == VERY_LOW_HEALTH #for a situation on level 5
  end #end low_health_with_captive_but_not_in_danger_v1?

  def low_health_with_captive_but_not_in_danger_v2?
    warrior.look[0].to_s == "Captive" && warrior.look[1].to_s == "wall" && warrior.health == VERY_LOW_HEALTH #for a situation on level 5
  end #end low_health_with_captive_but_not_in_danger_v3?

  def low_health_with_captive_but_not_in_danger_v3?
    warrior.look[0].to_s == "nothing" && warrior.health == 3 && warrior.look(:backward)[0].to_s == "nothing" && warrior.look[1].to_s != "Thick Sludge"#for a situation on level 5
  end #end low_health_with_captive_but_not_in_danger_v3?

  def low_health_but_no_danger_lvl6?
    warrior.look[0].to_s == "nothing" && warrior.health == 5 && warrior.look(:backward)[0].to_s == "nothing" && warrior.look[1].to_s == "nil" #for a situation on level 6
  end
end #ends class Player
