# frozen_string_literal: true

# required by one.rb

module Pickup4
  module_function

  def pickup_4_human(player_array, deck, discard_pile)
    begin
      puts 'and you have a pickup 4.'
      puts "Choose W for Wild or D (draw #{discard_pile.pickup_4_count} cards)"
      option = gets.chomp.downcase
      color = option[0]
      number = 'Pickup 4'
      color = validate_color(color)
      if color == 'Draw'
        draw_cards_pickup_4(player_array, deck, discard_pile)
        return "drew #{discard_pile.pickup_4_count} cards"
      end
      validate_card_in_hand(color, number, player_array[0])
    rescue InvalidColorError => e
      puts e.message
      retry
    rescue InvalidCardInHandError => e
      puts e.message
      retry
    end
    player_array[0].play_card(discard_pile, color, 'Pickup 4')
    return "played a #{color} Pickup 4"
  end

  def pickup_4_computer_1(player_array, deck, discard_pile)
    played_card = draw_cards_pickup_4(player_array, deck, discard_pile)
    return played_card
  end

  def pickup_4_computer_2(player_array, _deck, discard_pile)
    player_array[0].play_card(discard_pile, 'Wild', 'Pickup 4')
    played_card = "played Wild Pickup 4"
    return played_card
  end

  def pickup_4_computer(player_array, deck, discard_pile)
    if player_array[0].difficulty == 1
      played_card = pickup_4_computer_1(player_array, deck, discard_pile)
      return played_card
    else
        played_card = pickup_4_computer_2(player_array, deck, discard_pile)
      return played_card
    end
  end

  def draw_cards_pickup_4(player_array, deck, discard_pile)
    discard_pile.pickup_4_count.times do
      player_array[0].cards << deck.take_card
    end
    played_card = "drew #{discard_pile.pickup_4_count} cards"
    discard_pile.pickup_4_count = 0
    return played_card
  end

  def pickup_4_played(player_array, deck, discard_pile)
    if player_array[0].has_number?('Pickup 4') != 0 # current player has a Pickup 4 in their hand?
      if player_array[0].type == :computer
        played_card = pickup_4_computer(player_array, deck, discard_pile)
        return played_card
      else
        played_card = pickup_4_human(player_array, deck, discard_pile)
        return played_card
      end
    else
      played_card = draw_cards_pickup_4(player_array, deck, discard_pile)
    #   puts 'Press enter to continue'
    #   gets.chomp
      return played_card
    end
  end

  def pickup_4_played_before(player_array)
    if player_array.last.last_action == 'Pickup 4' # last round pickup 4 was played?
      puts 'A pickup 4 has been played'
      player_array.last.last_action = 'Pickup 4 actioned'
      return true
        end
    false
      end
end
