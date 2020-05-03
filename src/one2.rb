# frozen_string_literal: true

require 'colorize'
require 'tty-font'
require 'tty-box'
require_relative './classes/card'
require_relative './classes/deck'
require_relative './classes/player'
require_relative './classes/discard_pile'
require_relative 'validations'
require_relative 'initialize_game'
require_relative 'pre_turn'
require_relative 'pickup_2'
require_relative 'pickup_4'
require_relative 'turn'
require_relative 'computer_turn'
require_relative 'end_turn'
require_relative 'splash_screen'
require_relative 'cmd_arguments'

# argument passing from command line
first_arg, *max = ARGV
CmdArguments.validate_arg(first_arg, max)
CmdArguments.help_argument(first_arg)
choice = CmdArguments.choice_argument(first_arg)
max_num_players = CmdArguments.max_players_argument(first_arg, max)

ARGV.clear
while choice

  # Initialize game
  deck = InitializeGame.create_deck
  player_array = InitializeGame.create_players(max_num_players)
  InitializeGame.deal_cards(player_array, deck)
  discard_pile = InitializeGame.start_discard_pile(deck)
  match_card = discard_pile.cards.last
  winner = false
  # Start main game loop
  # Pre Turn Module
  until winner
    miss_turn = PreTurn.miss_turn_check(player_array, deck, discard_pile) # check if skip or reverse played
    PreTurn.clear_screen(player_array, miss_turn)
    unless miss_turn
      # Pickup 2 / pickup 4  Modules
      if player_array[0].type == :human
        player_array[0].display_table(player_array, match_card, deck, discard_pile)
      else
        player_array[0].display_table(player_array, match_card, deck, discard_pile)
      end
      if !Pickup2::pickup_2?(player_array, deck, discard_pile)
        pickup_4_played_before = Pickup4::pickup_4_played_before(player_array)
        if pickup_4_played_before 
          played_card = Pickup4::pickup_4_played(player_array, deck, discard_pile)
        else

          #Turn Module
          played_card = Turn.check_can_play(player_array[0], match_card, deck, discard_pile)
        end
      end
    end

    # End Turn Module
    winner = EndTurn.check_winner(player_array[0])
    match_card = EndTurn.match_card(played_card, match_card, discard_pile)
    player_array = EndTurn.next_player(player_array)
    EndTurn.deck_swap(deck, discard_pile)
    
  end
  # return to main screen after winner determined
  choice = SplashScreen.splash_screen_choice
end

