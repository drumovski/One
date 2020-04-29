# frozen_string_literal: true

# required by one2.rb

module EndTurn
  module_function

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
    match_card
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
    deck.cards = deck.replace_deck(discard_pile)
    deck
  end
end
