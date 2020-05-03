# frozen_string_literal: true

# required by one2.rb

module EndTurn
  module_function

  def colorize_wild(color, match_card)
    case color
      when 'Red'
        match_card.colorize = :light_red
      when 'Blue'
        match_card.colorize = :light_blue
      when 'Yellow'
        match_card.colorize = :light_yellow
      when 'Green'
        match_card.colorize = :light_green
    end
    return match_card
  end

  def choose_wild_color(match_card)
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
    match_card = colorize_wild(color, match_card)
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

  def match_card(played_card, match_card, discard_pile)
    if played_card
      match_card = discard_pile.cards.last
      if match_card.color == 'Wild'
        match_card = choose_wild_color(match_card)
      end
    end
    match_card
  end

end
