require 'test/unit'
require_relative '../classes/deck'
require_relative '../classes/card'
require_relative '../classes/discard_pile'

class DiscardPileTests < Test::Unit::TestCase


    def test_discard_pile
        my_deck = Deck.new
        my_deck.fill_deck
        my_discard_pile = DiscardPile.new
        my_discard_pile.cards = my_discard_pile.reset_discard_pile(my_deck)
        assert_equal(my_discard_pile.cards.length, 1)
    end
end