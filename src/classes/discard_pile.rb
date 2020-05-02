# frozen_string_literal: true

# required by one2.rb

class DiscardPile
  attr_accessor :cards
  attr_accessor :pickup_2_count
  attr_accessor :pickup_4_count

  def initialize
    @cards = []
    @pickup_2_count = 0
    @pickup_4_count = 0
    self
  end

  #starts the discard_pile with a basic color card only
  def reset_discard_pile(deck)
    @cards = []
    @cards << deck.take_card
    while @cards[0].color == 'Wild' || @cards[0].number.is_a?(String)
      deck.cards.unshift(@cards.pop)
      @cards << deck.take_card
    end
    @cards
  end
end
