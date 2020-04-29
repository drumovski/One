# frozen_string_literal: true

# required by one2.rb

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    self
  end

  def create_colors_basic(color, colorize)
    # add a single "0" number to the color
    @cards << Card.new(color, 0, colorize)
    i = 1
    9.times do
      # add two basic color cards to the deck numbered 1..9
      2.times { @cards << Card.new(color, i, colorize) }
      i += 1
    end
    @cards
  end

  def create_colors_special(color, colorize)
    2.times { @cards << Card.new(color, 'Skip', colorize) }
    2.times { @cards << Card.new(color, 'Reverse', colorize) }
    2.times { @cards << Card.new(color, 'Pickup 2', colorize) }
    @cards
  end

  def create_wild_cards(colorize)
    4.times { @cards << Card.new('Wild', 'Pickup 4', colorize) }
    3.times { @cards << Card.new('Wild', 'Card', colorize) }
    @cards
  end

  def fill_deck
    # create array of cards called deck
    create_colors_basic('Red', :light_red)
    create_colors_basic('Blue', :light_blue)
    create_colors_basic('Yellow', :light_yellow)
    create_colors_basic('Green', :light_green)
    create_colors_special('Blue', :light_blue)
    create_colors_special('Red', :light_red)
    create_colors_special('Yellow', :light_yellow)
    create_colors_special('Green', :light_green)
    create_wild_cards(:magenta)
    # create_custom_cards(:magenta) #may be implemented at a later stage
    @cards
  end

  #swaps discard pile and deck
  def replace_deck(discard_pile)
    @cards = discard_pile.cards
    @cards.shuffle!
    @cards
  end

  #returns a card from the deck
  def take_card
    @cards.pop
  end
end
