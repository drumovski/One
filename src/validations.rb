# frozen_string_literal: true

# required by One.rb

class InvalidNumberPlayersError < StandardError
  end

class InvalidPlayerNameError < StandardError
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

class InvalidStartChoice < StandardError
end

class InvalidArgumentError < StandardError
end


def validate_number_of_players(num, max_num_players)
  if num <= max_num_players && num > 0
    true
  else
    raise InvalidNumberPlayersError, "#{num} is not a valid number".colorize(:black).colorize(background: :light_red)
  end
end

def validate_name(name)
  if name != ''
    name
  else
    raise InvalidPlayerNameError, 'Name must not be empty'.colorize(:black).colorize(background: :light_red)
  end
  end

# only for computer players
# def validate_difficulty(difficulty)
#     if (difficulty == "0" or difficulty.to_i != 0) and (difficulty.to_i <= 3)
#         return true
#     else
#         raise InvalidDifficultyError, "#{difficulty} is not valid, must be 1, 2 or 3".colorize(:black ).colorize( :background => :light_red)
#     end
# end

def validate_basic_color(color)
  case color
  when 'r'
    'Red'
  when 'y'
    'Yellow'
  when 'b'
    'Blue'
  when 'g'
    'Green'
  else
    raise InvalidColorError, 'Invalid color. Choose a color (Y, B, R, G)'.colorize(:black).colorize(background: :light_red)
  end
end

def validate_color(color)
  case color
  when 'd'
    'Draw'
  when 'w'
    'Wild'
  when 'r'
    'Red'
  when 'y'
    'Yellow'
  when 'b'
    'Blue'
  when 'g'
    'Green'
  else
    raise InvalidColorError, 'Invalid color. Choose a color (Y, B, R, G) W (Wild) or enter D (Draw)'.colorize(:black).colorize(background: :light_red)
  end
end

def validate_number(number)
  if ((number == '0') || (number.to_i != 0)) && number.to_i >= 0 && number.to_i < 10
    return number.to_i
  end

  case number
  when 'p2'
    'Pickup 2'
  when 'p4'
    'Pickup 4'
  when 's'
    'Skip'
  when 'r'
    'Reverse'
  when 'c'
    'Card'
  else
    raise InvalidNumberError, 'Invalid number. Choose 0-9, P2 (Pickup 2), P4 (Pickup 4), S (Skip), R (Reverse) or WC (Wild Card)'.colorize(:black).colorize(background: :light_red)
  end
end

def validate_card_in_hand(color, number, player)
  if player.has_card(color, number)
    chosen_card = player.has_card(color, number)
    chosen_card
  else
    raise InvalidCardInHandError, 'You do not have that card in your hand.'.colorize(:black).colorize(background: :light_red)
  end
end

def validate_card_matches_discard(color, number, match_card)
  if match_card.number == number || match_card.color == color || color == 'Wild'
    true
  else
    raise InvalidCardMatchError, 'You can not play that card, it does not match the discard.'.colorize(:black).colorize(background: :light_red)
  end
end

def validate_start_choice(num)
  if num < 4 && num > 0
    true
  else
    raise InvalidStartChoice, "#{num} is not a valid number".colorize(:black).colorize(background: :light_red)
  end
end

#For cmd_arguments when running the game from terminal
def validate_first_arg(first_arg, max)
  if first_arg == "-s" || (first_arg == "-mp" && max[0].to_i != 0) || first_arg == "-h" || first_arg == NIL
    true
  else
    raise InvalidArgumentError, "Invalid argument. must be either -s (skip splash screen), -mp (change max players followed by new value) or -h (help)"
  end
end



