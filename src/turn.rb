# frozen_string_literal: true

# required by one2.rb

module Turn
  module_function

  def pick_up_card(player, deck)
    player.cards << deck.take_card
    player
  end

  # When current player has no cards to play
  def can_not_play(player, deck)
    puts "#{player.name} has no possible cards to play"
    puts 'Press enter to pick up from deck'
    gets.chomp
    pick_up_card(player, deck)
    player
  end

  def display_cards_can_play(cards, match_card)
    play_array = []
    cards.length.times do |i|
      if cards[i].number == match_card.number || cards[i].color == match_card.color || cards[i].color == 'Wild'
        play_array << cards[i]
      end
    end
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
        pick_up_card(player, deck)
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

  # Displays the current human player their hand and other info about other players and deck cards remaining
  def display_table(player_array, match_card, deck)
    player_array[0].cards = player_array[0].sort_cards
    puts "------------#{player_array[0].name}'s go------------".colorize(:green)
    (Player.player_count - 1).times do |i|
      if player_array[i + 1].cards.length == 1
        print "| #{player_array[i + 1].name} only has one card left!  ".colorize(:black).colorize(background: :light_red)
      else
        print "| #{player_array[i + 1].name} has #{player_array[i + 1].cards.length} cards  "
        end
    end
    puts "| #{deck.cards.length} Cards left in deck "
    puts '_______________________________________________________________________________________'
    puts  'Discard pile card to match is: '
    print TTY::Box.frame(height: 7, width: 12, border: :thick, align: :center, padding: 1) { " #{match_card.color.colorize(match_card.colorize)} \n#{match_card.number.to_s.colorize(match_card.colorize)}" } .colorize(match_card.colorize)
    puts
    puts "#{player_array[0].name}, your hand is: "
    puts
    player_array[0].cards.length.times do |i|
      print " | #{player_array[0].cards[i].color} #{player_array[0].cards[i].number} |".colorize(player_array[0].cards[i].colorize)
    end
    puts
    puts '_______________________________________________________________________________________'
    puts
  end
end