require 'test/unit'
require_relative '../classes/deck'
require_relative '../classes/card'
require_relative '../classes/discard_pile'

class DeckTests < Test::Unit::TestCase
    
    def test_correct_number_in_deck
        my_deck = Deck.new
        my_deck.fill_deck
        assert_equal(my_deck.cards.length, 107)
    end

    def test_take_card
        my_deck = Deck.new
        my_deck.fill_deck
        my_deck.take_card
        assert_equal(my_deck.cards.length, 106)
    end




end

