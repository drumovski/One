# frozen_string_literal: true

# required by one2.rb

module InitializeGame
  module_function

  def get_number_human_players(max_num_players)
    begin
      print "Please enter the number of human players (must be between 1 and #{max_num_players}): "
      num_human_players = gets.chomp.to_i
      verify = validate_number_of_players(num_human_players, max_num_players)
    rescue InvalidNumberPlayersError => e
      puts e.message
      retry
    end
    num_human_players.to_i
  end

  def get_names_of_human_players(num_human_players)
    begin
    print "Please enter first player's name: "
    name = gets.chomp
    name = validate_name(name)
    rescue InvalidPlayerNameError => e
    puts e.message
    retry
  end
    names = []
    names << name
    (num_human_players - 1).times do
    begin
      print "Please enter next player's name: "
      name = gets.chomp
      name = validate_name(name)
    rescue InvalidPlayerNameError => e
        puts e.message
        retry
    end
      names << name
    end
    names
  end

  def create_players(max_num_players)
    players_array = Array.new
    num_human_players = get_number_human_players(max_num_players)
    names = get_names_of_human_players(num_human_players)
    num_human_players.times do |i|
      players_array << Human.new(names[i])
    end
    players_array
  end

  def deal_cards(player_array, deck)
    # Deal 7 cards from the deck to each player
    7.times do
      player_array.length.times do |i|
        player_array[i].cards << deck.take_card
        i += 1
      end
    end
    player_array
  end

  def start_discard_pile(deck)
    # Get one valid card (not wild or skip or pickup) from deck and start the discard pile
    discard_pile = DiscardPile.new
    discard_pile.cards = discard_pile.reset_discard_pile(deck)
    discard_pile
  end

  def create_deck
    deck = Deck.new
    deck.fill_deck
    deck.cards = deck.cards.shuffle
    deck
  end
end
