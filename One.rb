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

    def initialize(name, type, difficulty = 0)
        puts "Initializing Player #{name}"
        @name = name
		@type = type
        @difficulty = difficulty
        @hand = Array.new
		@@player_count += 1
    end

    def take_a_card
         @hand << $deck.pop
    end






end
# Display rules



def create_colours_basic (colour)
    #add a single "0" number to the colour
    $deck.push({colour: colour, number: 0})
    i = 1
    9.times do
        #add two basic colour cards to the deck numbered 1..9
        2.times {$deck.push({colour: colour, number: i})}       
        i += 1
    end
    return $deck    
end

def create_colours_special(colour)
    #add the special colour cards to the deck
    2.times {$deck.push({colour: colour, number: "skip"})}
    2.times {$deck.push({colour: colour, number: "reverse"})}
    2.times {$deck.push({colour: colour, number: "pickup_2"})}
return $deck
end

def create_wild_cards()
    4.times {$deck.push({colour: "wild", number: "pickup_4"})}
    return $deck
end

def create_custom_cards()
    $deck.push({colour: "wild", number: "swap"})
    3.times {$deck.push({colour: "wild", number: ""})}
    return $deck
end

def create_deck ()
    # create array of 108 cards called deck
    puts "creating deck"
    create_colours_basic("blue")
    create_colours_basic("red")
    create_colours_basic("yellow")
    create_colours_basic("green")
    create_colours_special("blue")
    create_colours_special("red")
    create_colours_special("yellow")
    create_colours_special("green")
    create_wild_cards
    create_custom_cards
    puts "Created deck with #{$deck.length} cards"
    puts "shuffling deck"
    $deck = $deck.shuffle
    return $deck
end

def verify_number_of_players (num)
    if (num == "0" or num.to_i != 0) and (num.to_i <= $max_num_players)
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
def create_players(num_human_players,num_computer_players)
    if num_human_players != 0     
        print "Please enter first players name: "
        name = gets.chomp
        $player << Player.new(name, :human)
        (num_human_players-1).times do
            print "Please enter next players name: "
            name = gets.chomp
            $player << Player.new(name, :human)
        end
    end


    if num_computer_players != 0
        i = 1       
        num_computer_players.times do
            $verify = false
            until $verify
               print "Enter difficulty level for Computer player #{(i)} (1:easy, 2:normal, 3:hard): "
               difficulty = gets.chomp
               $verify = verify_difficulty(difficulty)
               difficulty = difficulty.to_i              
            end
            $player << Player.new(:computer, :computer, difficulty)
            i += 1
        end  
    end

end


# Determine number of players
def player_info
    $player = Array.new 
    $verify = false
    until $verify
        print "Please enter the number of human players (must be between 0 and #{$max_num_players}): "
        num_human_players = gets.chomp
        $verify = verify_number_of_players(num_human_players)
    end
    num_human_players = num_human_players.to_i
        create_players(num_human_players,0)
     
    $verify = false
    until $verify
        print "Please enter the number of computer players (must be between 0 and #{$max_num_players}): "
        num_computer_players = gets.chomp
        $verify = verify_number_of_players(num_computer_players)
        num_computer_players = num_computer_players.to_i
    end
    create_players(0,num_computer_players)
$number_of_players = num_computer_players + num_human_players 
end


# function Deal Cards
# Take cards (each hash out of the deck array and into the hands arrays (1 hand array eg player_1_hand for each player containing 7 random card hashes)
# example - player_1_hand = [{red, 7},{blue, 5}, {anycolour, null}, {yellow, pickup_2}, {red, 0}
# take random valid card from deck array and use it to start the discard array
# top_card_number = number from card chosen
# top_card_colour = colour from card chosen

def deal_cards
     #Deal 7 cards from the deck to each player
     7.times do
        i=0
        $number_of_players.times do
            $player[i].take_a_card
            i += 1
        end 
     end
end


puts "Welcome to ONE - a card game based on UNO"
#Global Variables
$max_num_players = 4
$deck = Array.new


create_deck

player_info
deal_cards
#DEBUGGING##############################
puts "player count: #{Player.player_count}"
puts "players to string #{$player.to_s}"
i = 0
Player.player_count.times do
    puts "Player name is #{$player[i].name} and type is #{$player[i].type} and difficulty is #{$player[i].difficulty}"
    puts "Player name is #{$player[i].name} and the hand is #{$player[i].hand}"
    i += 1
end  
puts
puts $deck.length
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
# only allow same colour or anycolour or same number/skip/reverse/pickup_2
# add card to discard array
# delete card from hand array
# if current_player hand array is empty, current_player is the winner
# if skip played, move next player in turn_order array to end
# if rev, reverse turn_order array
# if anycolour, ask player to choose colour and assign to top_card_colour
# if current_player hand array has only one card left output "ONE!"

# function Computer strategy hard?
# try to play colour first, if more than one choice, choose the card with a number not repeated in the hand array, if has pickup_2, save till last card
# if no colour, play same number
# if no colour or number, play anycolour and change colour to the colour most prevelent in hand array





