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
  player_array = InitializeGame.deal_cards(player_array, deck)
  discard_pile = InitializeGame.start_discard_pile(deck)
  match_card = discard_pile.cards.last
  winner = false
  # Start main game loop
  # Pre Turn Module
  until winner
    miss_turn = PreTurn.miss_turn_check(player_array, deck, discard_pile) # check if skip or reverse played
    PreTurn.clear_screen(player_array, miss_turn)
    unless miss_turn
      if match_card.number != 'Card' # means wild card was not played. 
        match_card = discard_pile.cards.last #If Wild played, the match card needs to be the color the player selected in the previous turn
        end 

      # Turn Module
      Turn.display_table(player_array, match_card, deck)
      if !Pickup2::pickup_2?(player_array, deck, discard_pile)
        match_card = Pickup4::pickup_4?(player_array, deck, discard_pile)
        if !match_card # a pickup 4 was not played
          match_card = discard_pile.cards.last
          can_play = player_array[0].can_play(match_card) #check to see if player has any cards they can play
          if !can_play
            player_array[0] = Turn.can_not_play(player_array[0], deck)
          else
            Turn.display_cards_can_play(player_array[0].cards, match_card)
            chosen_card = Turn.get_chosen_card(player_array[0], match_card, deck) #gets card to play from user
            if chosen_card != false # Player did not draw a card
              player_array[0].play_card(discard_pile, chosen_card.color, chosen_card.number) # current player plays a card
              match_card = discard_pile.cards.last
              if match_card.color == 'Wild'
                match_card = EndTurn.choose_wild_color(match_card)
              end
            end
          end
        end
      end
    end

    # End Turn Module
    winner = EndTurn.check_winner(player_array[0])
    player_array = EndTurn.next_player(player_array)
    if deck.cards.length < 4 # If deck runs out
      deck = EndTurn.deck_swap(deck, discard_pile)
      discard_pile = InitializeGame.start_discard_pile(deck)
    end
  end
  # return to main screen after winner determined
  choice = SplashScreen.splash_screen_choice
end
