# frozen_string_literal: true

# required by one.rb

module PreTurn
  module_function

  def skip(player_array)
    player_array.last.last_action = 'Played a Skip' # ensures last action doesn't trigger skip again next turn
    "#{player_array[0].name} got skipped!"
  end

  def reverse(player_array)
    player_array.last.last_action = 'Played a Reverse' # ensures last action doesn't trigger reverse again next turn
   if player_array.length > 2
    player_array.reverse!
    return "#{player_array.last.name} got reversed!"
   else
    return "#{player_array[0].name} got reversed!"
   end
  end

  def clear_screen(player_array, miss_turn)
    # system 'clear'
    if miss_turn != 'Reverse'
      puts miss_turn
    end
    puts "Its now #{player_array[0].name}'s go"
    puts "Please press enter when ready..."
    gets.chomp
    # system 'clear'
  end

  def miss_turn_check(player_array, deck, discard_pile)
    miss_turn = nil
    case player_array.last.last_action
    when 'Reverse'
      miss_turn = reverse(player_array)
      # clear_screen(player_array, miss_turn)
    when 'Skip'
      miss_turn = skip(player_array)
      # clear_screen(player_array, miss_turn)
    end
    miss_turn
  end
end
