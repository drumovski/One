require 'test/unit'
require_relative '../classes/deck'
require_relative '../classes/card'
require_relative '../classes/discard_pile'
require_relative '../classes/hand'
require_relative '../classes/player.rb'
require_relative '../initialize_game.rb'
require_relative '../validations.rb'
require_relative '../pre_turn.rb'

class PreTurnTests < Test::Unit::TestCase


    def test_pickup_2
        my_deck = Deck.new
        my_deck.fill_deck
        player_array = []
        player_array << Human.new("John")
        PreTurn::pickup_2(player_array, my_deck)
        assert_equal(player_array[0].cards.length, 2)
    end

    def test_pickup_4
        my_deck = Deck.new
        my_deck.fill_deck
        player_array = []
        player_array << Human.new("John")
        PreTurn::pickup_4(player_array, my_deck)
        assert_equal(player_array[0].cards.length, 4)
    end

    def test_reverse
        player_array = []
        player_array << Human.new("Jason")
        player_array << Human.new("Chantel")
        player_array << Human.new("Marshall")
        PreTurn::reverse(player_array)
        name_array = [player_array[0].name, player_array[1].name, player_array[2].name]
        assert_equal(name_array, ["Marshall", "Chantel", "Jason"])
    end

end