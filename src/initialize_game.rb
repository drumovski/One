# frozen_string_literal: true

# required by one.rb

module InitializeGame
  module_function

  def get_number_human_players(max_num_players)
    begin
      print "Please enter the number of human players (must be between 0 and #{max_num_players}): "
      num_human_players = gets.chomp.to_i
      verify = validate_number_of_players(num_human_players, 1, max_num_players)
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
    names = Array.new
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

  def get_number_computer_players(max_num_players, num_human_players)
    begin
        print "Please enter the number of computer players (must be between 0 and #{max_num_players}): "
        num_computer_players = gets.chomp.to_i
        validate_number_of_players(num_computer_players, num_human_players, max_num_players)
        rescue InvalidNumberPlayersError => e
            puts e.message
        retry
        end
        num_computer_players = num_computer_players.to_i
  end

  def get_computer_dificulty(num_computer_players)
    computer_difficulty_arr = Array.new
    n = 1       
    num_computer_players.times do
      begin
        print "Enter difficulty level for Computer player #{n} (1:easy, 2:normal, 3:hard): "
        difficulty = gets.chomp
        validate_difficulty(difficulty)
      rescue InvalidDifficultyError => e
        puts e.message
      retry
      end
      computer_difficulty_arr << difficulty.to_i                     
      n += 1
    end  
    return computer_difficulty_arr
  end

  def create_players(max_num_players)
    players_array = Array.new
    #Human
    num_human_players = get_number_human_players(max_num_players)
    if num_human_players != 0
      names = get_names_of_human_players(num_human_players)
    end
    num_human_players.times do |i|
      players_array << Human.new(names[i])
    end
    #Computer
    num_computer_players = get_number_computer_players(max_num_players, num_human_players)
    if num_computer_players != 0
      computer_difficulty_arr = get_computer_dificulty(num_computer_players)
    end
    num_computer_players.times do |i|
      players_array << Computer.new(computer_difficulty_arr[i])
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