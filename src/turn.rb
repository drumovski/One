# frozen_string_literal: true

# required by one2.rb

module Turn
  module_function

  # When current player has no cards to play
  def human_can_not_play(player, deck)
    puts "#{player.name} has no possible cards to play"
    puts 'Press enter to pick up from deck'
    gets.chomp
    player.cards << deck.take_card
    return false
  end

  def display_cards_can_play(cards, match_card, play_array)
    print 'You can play: '
    play_array.length.times do |i|
      print " |  #{play_array[i].color} #{play_array[i].number}  |".colorize(play_array[i].colorize)
    end
    puts
    puts '_______________________________________________________________________________________'
  end

  # asks user to choose a card to play from their hand
  def get_chosen_card(player, match_card, deck)
    begin
      puts 'Enter colour (R, B, Y, G) followed by a number(0-9) - Eg to play a Red 7, enter R7'
      puts 'Or, R, B, Y, G followed by R-Reverse, S-Skip or P2-Pickup 2 - Eg to play a Green Pickup 2, enter GP2'
      puts 'Enter WC for Wild Card, WP4 for Wild Pickup 4 '
      puts 'Enter D to pick up from the deck'
      puts 'What would you like to play? '
      option = gets.downcase
      color = option[0]
      number = option[1, 2].strip
      color = validate_color(color)
      if color == 'Draw'
        puts "#{player.name} chooses to pick up a card"
        player.cards << deck.take_card
        return false
      end
      number = validate_number(number)
      chosen_card = validate_card_in_hand(color, number, player)
      validate_card_matches_discard(color, number, match_card)
    rescue InvalidColorError => e
      puts e.message
      retry
    rescue InvalidNumberError => e
      puts e.message
      retry
    rescue InvalidCardInHandError => e
      puts e.message
      retry
    rescue InvalidCardMatchError => e
      puts e.message
      retry
    end
    chosen_card
  end

  def check_can_play(player, match_card, deck, discard_pile)
    play_array = player.cards_can_play(match_card) #check to see if player has any cards they can play
    
    #Human
    if player.type == :human
      if !play_array
        return human_can_not_play(player, deck)
      else
        return human_play_card(player, match_card, deck, discard_pile, play_array)
      end
    else
      #Computer    
      if !play_array
        ComputerTurn.computer_can_not_play(player, deck)
        return false
      else
        return ComputerTurn.computer_play_card(player, match_card, deck, discard_pile, play_array)
      end
    end
  end

  def human_play_card(player, match_card, deck, discard_pile, play_array)
      display_cards_can_play(player.cards, match_card, play_array)
      chosen_card = get_chosen_card(player, match_card, deck)
      if chosen_card != false # Player did not draw a card
        player.play_card(discard_pile, chosen_card.color, chosen_card.number) # current player plays a card
        return true
      else
        return false
      end   
  end
end