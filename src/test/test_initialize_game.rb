require 'test/unit'
require_relative '../classes/deck'
require_relative '../classes/card'
require_relative '../classes/discard_pile'
require_relative '../classes/hand'
require_relative '../classes/player.rb'
require_relative '../initialize_game.rb'
require_relative '../validations.rb'

class InitializeGameTests < Test::Unit::TestCase


    def test_deal_cards
        my_deck = Deck.new
        my_deck.fill_deck
        player_array = []
        player_array << Human.new("John")
        player_array = InitializeGame::deal_cards(player_array, my_deck)
        assert_equal(player_array[0].cards.length, 7)
    end

    def test_create_players
        max_num_players = 4
        #num_human_players enter 2
        player_array = InitializeGame::create_players(max_num_players)
        assert_equal(player_array.length, 2)

    end
end