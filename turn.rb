#required by One.rb

def check_winner
    if $player[0].hand.empty?
        puts "#{$player[0].name} is the winner !!!!! Yay for #{$player[0].name}!!!!!!"
        return true
    end
end

def skip_reverse
    if $skip_played
         puts "#{$player[0].name} got skipped!"
         $player.last.last_action = "Played a Skip"
         $player[0].last_action = "Got Skipped"
         $player.rotate!
         $skip_played = false
         return true
    end
     if $reverse_played
         puts "#{$player[0].name} got reversed!"
         $player.last.last_action = "Played a Reverse"
         $player[0].last_action = "Got Reversed"
         $player.reverse!
         $reverse_played = false
         return true
     else
         return false
     end
 end
 
 def end_turn
     case $player[0].last_action
     when "Pickup 2"
         $pickup_2_count += 1
     when "Pickup 4"
         $pickup_4_count += 1
         determine_match_card("Wild")
     when "Skip"
         $skip_played = true
     when "Reverse"
         $reverse_played = true
     when "Draw"
         $pickup_2_count = 0
         $pickup_4_count = 0
     when "Card" #wild
         determine_match_card("Wild")
     end
 end
 
 def turn
     miss_turn = skip_reverse
     if  !miss_turn 
         if $pickup_2_count > 0 
             pickup_2
             return 
         elsif $pickup_4_count > 0
             pickup_4
             return
         end
         if $player[0].type == :computer
             computer_turn
             return
         elsif $player[0].type == :human
             human_turn
             return
         end
 
     end
 end
 
 def color_card(color)
     case color
     when "Red"
         return :light_red
     when "Blue"
         return :light_blue
     when "Green"
         return :light_green
     when "Yellow"
         return :light_yellow
     end
 end
 
 def determine_match_card(match)
     if match == "Wild"
         if $player[0].type == :human
             choose_wild_color_human 
         elsif $player[0].type == :computer
             choose_wild_color_computer
         else
             puts "unknown player type for wild choice"
         end
     end
 end
 
 def pickup_2
     count = $player[0].has_number("Pickup 2")
     if count
         if $player[0].type == :human
             pickup_2_human(count)
         else
             pickup_2_computer(count)
         end
     else
         puts "Pickup 2 has been played. #{$player[0].name} has to pick up #{2*$pickup_2_count} cards"
         $player[0].take_a_card(2*$pickup_2_count).sort_hand
     end
 end
 
 def pickup_4
     count = $player[0].has_number("Pickup 4")
     if count
         if $player[0].type == :human
             pickup_4_human(count)
         else
             pickup_4_computer(count)
         end
     else
         puts "Pickup 4 has been played. #{$player[0].name} has to pick up #{4*$pickup_4_count} cards"
         $player[0].take_a_card(4*$pickup_4_count).sort_hand
     end
 end
 
 def next_turn
     if $skip_played || $reverse_played
     else
         $player.rotate!
     end
 end