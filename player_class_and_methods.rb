#required by One.rb






class Player
    attr_reader :name
    attr_reader :type
    attr_accessor :last_action
    attr_accessor :difficulty
    attr_accessor :hand


    @@player_count = 0

    def self.player_count
		@@player_count
	end

    def initialize(name, type)
        puts "Initializing Player #{name}"
        @name = name
		@type = type
        @hand = Array.new
        @last_action = "Initialized"
		@@player_count += 1
    end

    def sort_hand
        @hand = (@hand.sort_by { |hsh| hsh[:color] })
        self
    end

    def take_a_card(i)
        i.times do
         @hand << $deck.pop
         @last_action = "Draw"
        end
         self
    end

    def play_card(color, number)
        @hand.length.times do |i|
            if @hand[i][:color] == color && @hand[i][:number] == number
                $discard_pile << @hand[i]
                $match_card = @hand[i]
                @last_action = number
                puts "#{@name} played a #{color} #{number}"
                @hand.delete_at(i)
                return true
            end
            i += 1
        end
        puts "unexpected error, didn't play card"
        self
    end

    def has_card(color, number)
        @hand.length.times do |i|
            if @hand[i][:color] == color && @hand[i][:number] == number
                return true 
            end
            i += 1
        end
        return false
    end

    def has_color(color)
        @hand.length.times do |i|
            if @hand[i][:color] == color
                return true 
            end
            i += 1
        end
        return false
    end

    def has_wild(color)
        @hand.length.times do |i|
            if @hand[i][:color] == "Wild"
                return true 
            end
            i += 1
        end
        return false
        self
    end

    def has_number(number)
        count = 0
        @hand.length.times do |i|
            if @hand[i][:number] == number
                count += 1
            end
            i += 1
        end
        if count == 0
            return false
        else
            return count
            self
        end
    end

    def can_play_array(color, number)
        play_array = Array.new
        @hand.length.times do |i|
            if @hand[i][:number] == number || @hand[i][:color] == color || @hand[i][:color] == "Wild"
                play_array << @hand[i] 
            end
            i += 1
        end
        return play_array
    end


    # def which_colors(number)
    #     colors = Array.new
    #     @hand.length.times do |i|
    #         if @hand[i][:number] == number
    #             colors << @hand[i][:color]
    #         end
    #         i += 1
    #     end
    #     return colors
    # end


end

class Human < Player

    def initialize(name)
        @name = name
        @type = :human
        super @name, @type
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
end