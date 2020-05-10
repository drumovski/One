# frozen_string_literal: true

# required by one.rb

module EndTurn
  module_function

  def choose_wild_color_human(match_card)
    begin
      print 'Choose color for wild card (Y, B, R, G):'
      choice = gets.chomp.downcase
      color = validate_basic_color(choice)
    rescue InvalidColorError => e
      puts e.message
      retry
    end
    match_card.color = color
    match_card.number = 'Card'
    match_card.colorize = match_card.set_color
    return match_card
  end

  def choose_wild_color_computer(match_card, player_array)
    puts "now computer is choosing color"
    #chooses color the computer has the most of
    colors = player_array[0].color_count(player_array[0].cards)
    puts "colors array is #{colors}"
    keys = colors.keys
    puts "keys is #{keys}"
    color = keys[0]
    puts "color is #{color}"
    if player_array[1].cards.length == 1 && (player_array[1].last_action == "Card" || player_array[1].last_action == "Pick up 4") && match_card.color == color
      color = keys[1]
    end
    match_card.color = color
    puts "computer chooses #{color}"
    return match_card
  end

  def check_winner(player)
    if player.cards.empty?
      font = TTY::Font.new(:standard)
      puts font.write("#{player.name}").colorize(:green)
      puts font.write("wins!").colorize(:green)
      puts font.write("Yay  for #{player.name}!").colorize(:green)
      puts 'press enter to return to the main screen'
      gets.chomp
      true
    else
      false
    end
  end

  def next_player(player_array)
    player_array.rotate
  end

  #When deck runs out of cards
  def deck_swap(deck, discard_pile)
    if deck.cards.length < 16 # If deck runs out
      discard_pile.cards.concat(deck.cards)
      deck.cards.clear
      deck.cards = deck.replace_deck(discard_pile)
      discard_pile = discard_pile.reset_discard_pile(deck)
    end
  end

  def match_card(played_card, match_card, discard_pile, player_array)
    if played_card
      match_card = discard_pile.cards.last
      if match_card.color == 'Wild'
        if player_array[0].type == :human
          match_card = choose_wild_color_human(match_card)
        else
          match_card = choose_wild_color_computer(match_card, player_array)
        end
      end
    end
    match_card
  end

end
