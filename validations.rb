# required by One.rb

class InvalidNumberPlayersError < StandardError
end

class InvalidDifficultyError < StandardError
end
    
class InvalidOptionError < StandardError
end

class InvalidColorError < StandardError
end

class InvalidCardInHandError < StandardError
end

class InvalidNumberError < StandardError
end

class InvalidCardMatchError < StandardError
end

# def validate_option(color, number)
#     puts 'Validation in progress up here...'
#     if color == "d" or color == "w" && !number
#         return true
#     elsif color == "r" or color == "y" or color == "b" or color == "g" or color == "w" 
#             puts "color valid, moving on"
#             if (number == "0" or number.to_i != 0) or number == "r" or number == "s" or number == "p" or number == "w"
#                 puts "number valid"
#             return true
#             end 
#     else
#     raise InvalidOptionError, 'terror statement'
#   end
# end

def validate_number_of_players (num, max_num_players)
    if (num == "0" or num.to_i != 0) && (num.to_i <= max_num_players)
        return true 
    else
        raise InvalidNumberPlayersError, "#{num} is not a valid number".colorize(:black ).colorize( :background => :light_red)
    end
end

def validate_difficulty(difficulty)
    if (difficulty == "0" or difficulty.to_i != 0) and (difficulty.to_i <= 3)
        return true 
    else
        raise InvalidDifficultyError, "#{difficulty} is not valid, must be 1, 2 or 3".colorize(:black ).colorize( :background => :light_red)
    end
end

def validate_basic_color(color)
    puts 'Color Validation in progress up here...'
    case color
    when "r"
        return "Red"
    when "y"
        return "Yellow"
    when "b"
        return "Blue"
    when "g"
        return "Green"
    else
        raise InvalidColorError, "Invalid color. Choose a color (Y, B, R, G)".colorize(:black ).colorize( :background => :light_red)
    end
end

def validate_color(color)
    puts 'Color Validation in progress up here...'
    case color
    when "d"
        return "Draw"
    when "w"
        return "Wild"
    when "r"
        return "Red"
    when "y"
        return "Yellow"
    when "b"
        return "Blue"
    when "g"
        return "Green"
    else
        raise InvalidColorError, "Invalid color. Choose a color (Y, B, R, G) W (Wild) or enter D (Draw)".colorize(:black ).colorize( :background => :light_red)
    end
end

def validate_number(number)
    puts 'Number Validation in progress up here...'
    if (number == "0" or number.to_i != 0)
        return number.to_i
    end
    case number
    when "p2"
        return "Pickup 2"
    when "p4"
        return "Pickup 4"
    when "s"
        return "Skip"
    when "r"
        return "Reverse"
    when "i"
        return "Card"
    else
        raise InvalidNumberError, "Invalid number. Choose 0-9, P2 (Pickup 2), P4 (Pickup 4), S (Skip), R (Reverse) or Wi (Wild)".colorize(:black ).colorize( :background => :light_red)
    end
end

def validate_card_in_hand(color, number)
    puts 'validate_card_in_hand in progress up here...'
    if $player[0].has_card(color, number)
        puts "#{$player[0].name} has card in hand"
        return false
    else
        raise InvalidCardInHandError, "You do not have that card in your hand.".colorize(:black ).colorize( :background => :light_red)
    end
end

def validate_card_matches_discard(color, number, match_card)
    puts 'validate_card_matches_discard in progress up here...'
    if match_card[:number] == number || match_card[:color] == color || color == "Wild"
        puts "#{$player[0].name} can play the #{color} #{number}, it matches the #{match_card}"
        return true
    else
        raise InvalidCardMatchError, "You can not play that card, it does not match the discard.".colorize(:black ).colorize( :background => :light_red)
    end
end
















# def human_turn(match_card)
#     end_turn = false
#     play_array = can_play_array(match_card[:color], match_card[:number])
#     until end_turn
#         if play_array.empty?
#             puts "#{$player[0].name} has no possible cards to play"
#             puts "Enter any key to pick up from deck"
#             option = gets.chomp
#             $player[0].take_a_card(1).sort_hand
#             end_turn = true
#         else
#             verify_option = false
#             verify_card = false
#             until verify_card
#                 until verify_option
#                     puts "Enter R, B, Y, G followed by a number(0-9), R-Reverse, S-Skip or P2-Pickup 2. Eg: to play a Red 7, enter R7"
#                     puts "Enter W for Wild, WP4 for Wild Pickup_4 "
#                     puts "Enter D to pick up from the deck"
#                     puts "What card would you like to play? "
#                     option = gets.downcase.delete(' ')
#                     color = option[0]
#                     number = option[1][2]
#                     puts "option entered: #{option}"
#                     puts "first char: #{option[0]}"
#                     puts "2nd char: #{option[1][2]}"
#                     verify_option = confirm_option(color, number)
#                 end
#                 color = assign_color(color)
#                 number = assign_number(number, color)
#                 puts "selection is: #{color} #{number}"
#                 verify_card = confirm_card(color, number, match_card, $player[0])
#                 verify_card = true
#             end
#             #play_card(color, number, $player[0])
#         end
#     end   
# end