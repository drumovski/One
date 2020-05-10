# frozen_string_literal: true

# required by one.rb

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    self
  end

  def create_colors_basic(color)
    # add a single "0" number to the color
    @cards << Card.new(color, 0)
    i = 1
    9.times do
      # add two basic color cards to the deck numbered 1..9
      2.times { @cards << Card.new(color, i) }
      i += 1
    end
    @cards
  end

  def create_colors_special(color)
    2.times { @cards << Card.new(color, 'Skip') }
    2.times { @cards << Card.new(color, 'Reverse') }
    2.times { @cards << Card.new(color, 'Pickup 2') }
    @cards
  end

  def create_wild_cards
    4.times { @cards << Card.new('Wild', 'Pickup 4') }
    3.times { @cards << Card.new('Wild', 'Card') }
    @cards
  end

  def color_deck
    @cards.map { |i| i.set_color}
  end

  def fill_deck
    #create array of cards called deck
    create_colors_basic('Red')
    create_colors_basic('Blue')
    create_colors_basic('Yellow')
    create_colors_basic('Green')
    create_colors_special('Blue')
    create_colors_special('Red')
    create_colors_special('Yellow')
    create_colors_special('Green')
    create_wild_cards
    # create_custom_cards(:magenta) #may be implemented at a later stage
    color_deck
    @cards
  end


  #swaps discard pile and deck
  def replace_deck(discard_pile)
    @cards.concat(discard_pile.cards)
    @cards.shuffle!
    @cards
  end

  #returns a card from the deck
  def take_card
    @cards.pop
  end
end
