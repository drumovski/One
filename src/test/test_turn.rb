require 'test/unit'
require_relative '../classes/deck'
require_relative '../classes/card'
require_relative '../classes/discard_pile'
require_relative '../classes/hand'
require_relative '../classes/player.rb'
require_relative '../turn.rb'


class TurnTests < Test::Unit::TestCase


    def test_pick_up_card
        my_deck = Deck.new
        my_deck.fill_deck
        player_array = []
        player_array << Human.new("John")
        player = Turn::pick_up_card(player_array[0], my_deck)
        assert_equal(player.cards.length, 1)
    end


end