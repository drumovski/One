# frozen_string_literal: true

# required by one2.rb

module PreTurn
  module_function

  def skip(player_array)
    player_array.last.last_action = 'Played a Skip' # ensures last action doesn't trigger skip again next turn
    "#{player_array[0].name} got skipped!"
  end

  def reverse(player_array)
    player_array.last.last_action = 'Played a Reverse' # ensures last action doesn't trigger reverse again next turn
    player_array.reverse! if player_array.length > 2
    'Reverse'
  end

  # def pickup_2(player_array, deck)
  #   player_array.last.last_action = 'Played a Pickup 2' # ensures last action doesn't trigger pickup 2 again next turn
  #   player_array[0].cards << deck.take_card
  #   "Pickup 2 has been played. #{player_array[0].name} has to pick up 2 cards"
  # end

  # def pickup_4(player_array, deck)
  #   player_array.last.last_action = 'Played a Pickup 4' # ensures last action doesn't trigger pickup 4 again next turn
  #   player_array[0].cards << deck.take_card
  #   "Pickup 4 has been played. #{player_array[0].name} has to pick up 4 cards"
  # end

  def clear_screen(player_array, miss_turn)
    system 'clear'
    if miss_turn != 'Reverse'
      puts "Its now #{player_array[0].name}'s go, other players must avert their eyes!"
      puts miss_turn
    else
      puts "#{player_array[0].name} played a reverse"
    end
    puts "#{player_array[0].name}, Please press enter when ready..."
    gets.chomp
    system 'clear'
  end

  def miss_turn_check(player_array, deck, discard_pile)
    miss_turn = nil
    case player_array.last.last_action
    when 'Reverse'
      miss_turn = reverse(player_array)
    when 'Skip'
      miss_turn = skip(player_array)
    # when 'Pickup 2'
    #   miss_turn = Pickup2::pickup_2?(player_array, deck, discard_pile)
    # when 'Pickup 4'
    #   miss_turn = pickup_4(player_array, deck)
    end
    miss_turn
  end
end
