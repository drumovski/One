# frozen_string_literal: true

# required by one2.rb

class Player
  attr_reader :name
  attr_reader :type
  attr_accessor :last_action
  attr_accessor :difficulty
  attr_accessor :cards

  @@player_count = 0

  def self.player_count
    @@player_count
  end

  def initialize(name, type)
    @name = name
    @type = type
    @cards = Array.new
    @last_action = 'Initialized'
    @@player_count += 1
  end

    #given a color and number, removes card from players hand and adds it to discard_pile
  def play_card(discard_pile, color, number)
    @cards.length.times do |i|
      unless @cards[i].color == color && @cards[i].number == number
        next
        end

      discard_pile.cards << @cards[i]
      @last_action = number
      @cards.delete_at(i)
      return true
    end
    puts "unexpected error, didn't play card" # given validation, this should not be seen
    self
  end

      #sort the cards in the players hand so they are easier to read when displayed
      def sort_cards
        return @cards.sort_by(&:color)
        self
      end
    
      # def display_hand
      #   puts '----------------------------------------------------------------------'
      #   @cards.length.times do |i|
      #     print " #{@cards[i].color.colorize(@cards[i].colorize)} #{@cards[i].number.to_s.colorize(@cards[i].colorize)} ||"
      #   end
      #   puts
      #   puts '----------------------------------------------------------------------'
      # end
    
      #checks if there are any cards the player has that can be played by comparing to the match-card
      def can_play(match_card)
        @cards.length.times do |i|
          if @cards[i].color == match_card.color || @cards[i].number == match_card.number || @cards[i].color == 'Wild'
            return true
          end
        end
        false
      end
    
      #given a color and number, returns the card if the player has it in their hand
      def has_card(color, number)
        @cards.length.times do |i|
          return @cards[i] if @cards[i].color == color && @cards[i].number == number
        end
        false
      end
end

class Human < Player
  def initialize(name)
    @name = name
    @type = :human
    super @name, @type
  end
end
