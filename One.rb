# ONE

class Player
    attr_reader :name
    attr_reader :type
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
		@@player_count += 1
    end

    def take_a_card
         @hand << $deck.pop  
    end

    def sort_hand
        @hand = (@hand.sort_by { |hsh| hsh[:color] })
    end

    def has_color(color)
        i = 0
        @hand.length.times do
            if @hand[i][:color] == color or @hand[i][:color] == "Wild"
                return true 
            end
            i += 1
        end
        return false
    end

    def has_number(number)
        i = 0
        @hand.length.times do
            if @hand[i][:number] == number
                return true       
            end
            i += 1
        end
        return false
    end


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

# Display rules



def create_colors_basic (color)
    #add a single "0" number to the color
    $deck.push({color: color, number: 0})
    i = 1
    9.times do
        #add two basic color cards to the deck numbered 1..9
        2.times {$deck.push({color: color, number: i})}       
        i += 1
    end
    return $deck    
end

def create_colors_special(color)
    #add the special color cards to the deck
    2.times {$deck.push({color: color, number: "Skip"})}
    2.times {$deck.push({color: color, number: "Reverse"})}
    2.times {$deck.push({color: color, number: "Pickup_2"})}
return $deck
end

def create_wild_cards
    4.times {$deck.push({color: "Wild", number: "Pickup_4"})}
    return $deck
end

def create_custom_cards
    $deck.push({color: "Wild", number: "Swap"})
    3.times {$deck.push({color: "Wild", number: ""})}
    return $deck
end

def create_deck
    # create array of 108 cards called deck
    puts "Creating deck"
    create_colors_basic("Blue")
    create_colors_basic("Red")
    create_colors_basic("Yellow")
    create_colors_basic("Green")
    create_colors_special("Blue")
    create_colors_special("Red")
    create_colors_special("Yellow")
    create_colors_special("Green")
    create_wild_cards
    create_custom_cards
    puts "Created deck with #{$deck.length} cards"
    puts "Shuffling deck"
    $deck = $deck.shuffle
    return $deck
end

def verify_number_of_players (num, max_num_players)
    if (num == "0" or num.to_i != 0) and (num.to_i <= max_num_players)
        return true 
    else
        puts "#{num} is not a valid number"
    end

end


def verify_difficulty(difficulty)
    puts "verify_difficulty(difficulty)"
    if (difficulty == "0" or difficulty.to_i != 0) and (difficulty.to_i <= 3)
        return true 
    else
        puts "#{difficulty} is not valid "
    end
end

# create profiles -eg  player_info[{type: "human", difficulty: "easy", name: "Blah"},{type: "computer", difficulty: "easy", name: "Blah"}
def create_players(num_human_players,num_computer_players, player)
    i = 1
    if num_human_players != 0     
        print "Please enter first players name: "
        name = gets.chomp
        player << Human.new(name)
        (num_human_players-1).times do
            
            print "Please enter next players name: "
            name = gets.chomp
            player << Human.new(name)
            i += 1
        end
    end


    if num_computer_players != 0
        n = 1       
        num_computer_players.times do
            verify = false
            until verify
               print "Enter difficulty level for Computer player #{n} (1:easy, 2:normal, 3:hard): "
               difficulty = gets.chomp
               verify = verify_difficulty(difficulty)
               difficulty = difficulty.to_i              
            end
            player << Computer.new(difficulty)
            n += 1
            i += 1
        end  
    end
    puts "returning player :#{player}"
return player
end


# Determine number of players
def player_info(max_num_players)
    player = Array.new 
    verify = false
    until verify
        print "Please enter the number of human players (must be between 0 and #{max_num_players}): "
        num_human_players = gets.chomp
        verify = verify_number_of_players(num_human_players, max_num_players,)
    end
    num_human_players = num_human_players.to_i
        player = create_players(num_human_players,0, player)
     
    verify = false
    until verify
        print "Please enter the number of computer players (must be between 0 and #{max_num_players}): "
        num_computer_players = gets.chomp
        verify = verify_number_of_players(num_computer_players, max_num_players)
        num_computer_players = num_computer_players.to_i
    end
    create_players(0,num_computer_players, player)

return player
end


# function Deal Cards
# Take cards (each hash out of the deck array and into the hands arrays (1 hand array eg player_1_hand for each player containing 7 random card hashes)
# example - player_1_hand = [{red, 7},{blue, 5}, {anycolor, null}, {yellow, pickup_2}, {red, 0}
# take random valid card from deck array and use it to start the discard array
# top_card_number = number from card chosen
# top_card_color = color from card chosen
def deal_cards(player)
    #Deal 7 cards from the deck to each player
    7.times do
       i=0
       Player.player_count.times do
           player[i].take_a_card
           i += 1
       end 
    end
end

def start_discard_pile
    #Get one valid card from deck and start the discard pile
    discard_pile = Array.new
    discard_pile << $deck.pop
    while discard_pile[0][:color] == "wild" or discard_pile[0][:number].is_a? String do
       $deck.unshift(discard_pile.pop)
       discard_pile << $deck.pop     
    end
    return discard_pile
end


def display_table(current_player, match_card)
    #Displays the current human player their hand
    if current_player.type == :human
        puts "----------------------------------------------------"
        puts "Discard pile card to match is "
        puts "|| #{match_card[:color]} #{match_card[:number]} ||"
        puts
        current_player.sort_hand
        puts "Player #{current_player.name}'s go, your hand is: " 
        i=0
        current_player.hand.length.times do
            print "#{current_player.hand[i][:color]} #{current_player.hand[i][:number]}  ||  "
            i += 1
        end
        puts
        puts "----------------------------------------------------"
    end
end

def turn(player, match_card)
    if player[0].has_color(match_card[:color])
        puts "color match"
    else
        puts "color missmatch"
    end

    if player[0].has_number(match_card[:number])
        puts "number match"
    else
        puts "number missmatch"
    end

    if player[0].type == :human
        human_turn
    elsif player[0].type == :computer
        computer_turn
    end
end

def human_turn
end


def computer_turn
end

puts "Welcome to ONE - a card game based on UNO"
#Define Variables
max_num_players = 4
$deck = Array.new

create_deck
player = player_info(max_num_players)
deal_cards(player)
discard_pile = start_discard_pile
display_table(player[0], discard_pile.last)
turn(player, discard_pile.last)


#DEBUGGING##############################
# puts "player count: #{Player.player_count}"
#  puts "players to string #{player.to_s}"
#  i = 0
#  Player.player_count.times do
#      puts "Player name: #{player[i].name} type: #{player[i].type} diff: #{player[i].difficulty} hand: #{player[i].hand}"
#     i += 1
#  end  
# puts
# puts $deck.length
# puts "discard pile is #{discard_pile}"
 #DEBUGGING##############################


#make array turn_order [player_1, player_2, etc]

# create profiles - player_1_info = hash {type: human/computer, difficulty: easy}


# Difficulty?

# function Human interface
# show human their player_1_hand
# input from human - card to play 
# ensure it follows turn logic


# function Turn logic
# if pickup_2 give 2 cards to next player in turn_order unless they have a pickup_2 also.
# if pickup_4 give 4 cards to next player in turn_order unless they have a pickup_4 also.
# only allow same color or anycolor or same number/skip/reverse/pickup_2
# add card to discard array
# delete card from hand array
# if current_player hand array is empty, current_player is the winner
# if skip played, move next player in turn_order array to end
# if rev, reverse turn_order array
# if anycolor, ask player to choose color and assign to top_card_color
# if current_player hand array has only one card left output "ONE!"

# function Computer strategy hard?
# try to play color first, if more than one choice, choose the card with a number not repeated in the hand array, if has pickup_2, save till last card
# if no color, play same number
# if no color or number, play anycolor and change color to the color most prevelent in hand array





