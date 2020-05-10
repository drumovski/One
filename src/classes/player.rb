# frozen_string_literal: true

# required by one.rb

class Player
  attr_reader :name
  attr_reader :type
  attr_accessor :last_action
  attr_reader :difficulty
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
      if number == "Pickup 2"
        discard_pile.pickup_2_count += 2
      end
      if number == "Pickup 4"
        discard_pile.pickup_4_count += 4
      end
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
      def cards_can_play(match_card)
        play_array = []
        @cards.length.times do |i|
          if @cards[i].color == match_card.color || @cards[i].number == match_card.number || @cards[i].color == 'Wild'
            play_array << @cards[i] 
          end 
        end
        if play_array.empty?
          return false
        else
          return play_array
        end
      end
    
      #given a color and number, returns the card if the player has it in their hand
      def has_card(color, number)
        @cards.length.times do |i|
          return @cards[i] if @cards[i].color == color && @cards[i].number == number
        end
        false
      end

      def has_color(color)
        @cards.length.times do |i|
          return @cards[i] if @cards[i].color == color
        end
        false
      end

      def has_number?(number)
        how_many_cards = 0
        @cards.length.times do |i|
          if @cards[i].number == number
            how_many_cards += 1
          end
        end
        return how_many_cards
      end
end

class Human < Player
  def initialize(name)
    @name = name
    @type = :human
    super @name, @type
  end

  # Displays the current human player their hand and other info about other players and deck cards remaining
  def display_table(player_array, match_card, deck, discard_pile)
    @cards = sort_cards
    puts "------------#{@name}'s go------------".colorize(:green)
    (player_array.length).times do |i|
      if player_array[i].cards.length == 1
        print "| #{player_array[i].name} only has one card left!  ".colorize(:black).colorize(background: :light_red)
      else
        print "| #{player_array[i].name} has #{player_array[i].cards.length} cards  "
        end
    end
    puts "| #{deck.cards.length} cards left in deck "
    #puts "| #{discard_pile.cards.length} cards in discard pile "
    puts '_______________________________________________________________________________________'
    puts  'Discard pile card to match is: '
    print TTY::Box.frame(height: 7, width: 12, border: :thick, align: :center, padding: 1) {" #{match_card.color.colorize(match_card.colorize)} \n#{match_card.number.to_s.colorize(match_card.colorize)}"}.colorize(match_card.colorize)
    puts
    puts "#{@name}, your hand is: "
    puts
    @cards.length.times do |i|
      print " | #{@cards[i].color} #{@cards[i].number} |".colorize(@cards[i].colorize)
    end
    puts
    puts '_______________________________________________________________________________________'
    puts
  end
end



class Computer < Player

  @@computer_names = ["Cerebro", "Duotronics", "HAL 9000", "C-3PO", "Deep Thought", "Mother", "Shirka", "Master Computer Program", "KITT", "WOPR", "Skynet", "ChiChi 3000", "Vector Sigma", "Vicki Smith-Lawson", "Ziggy", "Project 2501", "T-800", "Dell Latitude C840", "Dr. Know", "Spatial Operating Environment", "The Red Queen", "V.I.K.I", "Icarus", "GlaDOS", "JARVIS", "ARIIA", "Vi", "Gigolo Joe", "Johnny 5", "Robby the Robot", "Data", "Ash", "Gort", "Marvin", "Wall-E", "ED209", "Chappie", "Agent Smith", "Optimus Prime", "Roy Batty", "R2D2", "The Iron Giant", "T-1000", "Bomb 20", "Joshua", "GERTY", "V'ger", "The Borg", "Holly", "Ultron", "PipBoy 2000", "Sonny", "Teddy", "David", "Fembots", "Astro Boy", "Johnny Cab", "Vision", "Dot Matrix", "Ava", "TARS", "CASE", "The Stepford Wives", "Baymax", "The Gunslinger", "Maximillian", "EVE", "Pris", "Alex Murphy", "Bishop", "Motoko Kusanagi", "BB-8", "K-2SO"]
  
  def initialize (difficulty)
      @difficulty = difficulty
      @name = @@computer_names.sample
      @type = :computer
      super @name, @type
  end

    # Displays the current computer player their hand and other info about other players and deck cards remaining
    def display_table(player_array, match_card, deck, discard_pile)
      @cards = sort_cards
      puts "------------#{@name}'s go------------".colorize(:green)
      (player_array.length).times do |i|
        if player_array[i].cards.length == 1
          print "| #{player_array[i].name} only has one card left!  ".colorize(:black).colorize(background: :light_red)
        else
          print "| #{player_array[i].name} has #{player_array[i].cards.length} cards  "
          end
      end
      puts "| #{deck.cards.length} cards left in deck "
      #puts "| #{discard_pile.cards.length} cards in discard pile "
      puts '_______________________________________________________________________________________'
      puts  'Discard pile card to match is: '
      print TTY::Box.frame(height: 7, width: 12, border: :thick, align: :center, padding: 1) {" #{match_card.color.colorize(match_card.colorize)} \n#{match_card.number.to_s.colorize(match_card.colorize)}"}.colorize(match_card.colorize)
      puts
      puts "#{@name}, your hand is: "
      puts
      @cards.length.times do |i|
        print " | #{@cards[i].color} #{@cards[i].number} |".colorize(@cards[i].colorize)
      end
      puts
      puts '_______________________________________________________________________________________'
      puts
    end

    def color_count(arr)
      colors = {"Yellow"=> 0, "Red"=> 0, "Green"=> 0, "Blue"=> 0}
      arr.each do |i|
        case i.color
        when "Yellow"
          colors["Yellow"] += 1
        when "Red"
          colors["Red"] += 1
        when "Green"
          colors["Green"] += 1
        when "Blue"
          colors["Blue"] += 1
        end
      end
      colors = colors.sort_by{|k,v| -v}.to_h #sorts highest value first
    end

end