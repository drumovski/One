# frozen_string_literal: true

# required by one

module Pickup2
  module_function

  def pickup_2_human(player_array, deck, discard_pile)
    begin
      puts 'and you have a pickup 2.'
      puts "Choose pickup color (Y,B,R,G) or D (draw #{discard_pile.pickup_2_count} cards)"
      option = gets.chomp.downcase
      color = option[0]
      number = 'Pickup 2'
      color = validate_color(color)
      if color == 'Draw'
        draw_cards_pickup_2(player_array, deck, discard_pile)
        return "drew #{discard_pile.pickup_2_count} cards"
      end
      validate_card_in_hand(color, number, player_array[0])
    rescue InvalidColorError => e
      puts e.message
      retry
    rescue InvalidCardInHandError => e
      puts e.message
      retry
    end
    player_array[0].play_card(discard_pile, color, 'Pickup 2')
    return "played a #{color} Pickup 2"
  end

  def pickup_2_computer_1(player_array, deck, discard_pile)
    played_card = draw_cards_pickup_2(player_array, deck, discard_pile)
    return played_card
  end

  def pickup_2_computer_2(player_array, _deck, discard_pile)
    color = false
    i = 0
    until color
      if player_array[0].cards[i].number == 'Pickup 2'
        color = player_array[0].cards[i].color
      end
      i += 1
    end
    player_array[0].play_card(discard_pile, color, 'Pickup 2')
    played_card = "played a #{color} Pickup 2"
    return played_card
  end

  def pickup_2_computer(player_array, deck, discard_pile)
    if player_array[0].difficulty == 1
        played_card = pickup_2_computer_1(player_array, deck, discard_pile)
    else
        played_card = pickup_2_computer_2(player_array, deck, discard_pile)
    end
    return played_card
  end

  def draw_cards_pickup_2(player_array, deck, discard_pile)
    discard_pile.pickup_2_count.times do
      player_array[0].cards << deck.take_card
    end
    played_card = "drew #{discard_pile.pickup_2_count} cards"
    discard_pile.pickup_2_count = 0
    return played_card
  end

  def pickup_2_played(player_array, deck, discard_pile)
    if player_array[0].has_number?('Pickup 2') != 0 # current player has a Pickup 2 in their hand?
      if player_array[0].type == :computer
        played_card = pickup_2_computer(player_array, deck, discard_pile)
        return played_card
      else
        played_card = pickup_2_human(player_array, deck, discard_pile)
        return played_card
      end
    else
      played_card = draw_cards_pickup_2(player_array, deck, discard_pile)
    #   puts 'Press enter to continue'
    #   gets.chomp
      return played_card
    end
  end

  def pickup_2_played_before(player_array)
    if player_array.last.last_action == 'Pickup 2' # last round pickup 2 was played?
      puts 'A pickup 2 has been played'
      player_array.last.last_action = 'Pickup 2 actioned'
      return true
    end
    false
  end
end
