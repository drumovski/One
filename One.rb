# ONE - a cad game based on UNO

require 'colorize'

require_relative 'create_cards.rb'
require_relative 'player_class_and_methods.rb'
require_relative 'create_players.rb'
require_relative 'validations.rb'
require_relative 'human_turn.rb'
require_relative 'computer_turn.rb'
require_relative 'turn.rb'




# Display rules


def display_table(rounds)
    #Displays the current human player their hand and other info
    if $player[0].type == :human
        i = 1
        (Player.player_count - 1).times do
            if $player[i].hand.length == 1
            print "#{$player[i].name} only has one card left!  ".colorize(:magenta)
            else
                print "#{$player[i].name} has #{$player[i].hand.length} cards  "
            end
            i += 1
        end
        puts "Round # #{rounds}"
        puts 
        puts "----------------------------------------------------"
        print "Discard pile card to match is: "
        puts "|| #{$match_card[:color].colorize($match_card[:colorize])} #{$match_card[:number].to_s.colorize($match_card[:colorize])} ||"
        puts
        puts "#{$player[0].name}'s go, your hand is: " 
        $player[0].hand.length.times do |i|
            print "|  #{$player[0].hand[i][:color].colorize($player[0].hand[i][:colorize])} #{$player[0].hand[i][:number].to_s.colorize($player[0].hand[i][:colorize])}  |"
            i += 1
        end
        puts
        puts "----------------------------------------------------"
    end
end

puts " _______  __    _  _______  "
puts "|       ||  |  | ||       | "
puts "|   _   ||   |_| ||    ___| "
puts "|  | |  ||       ||   |___  "
puts "|  |_|  ||  _    ||    ___| "
puts "|       || | |   ||   |___  "
puts "|_______||_|  |__||_______| "
puts 
puts "Welcome to ONE - a card game based on UNO"

#Define Variables
max_num_players = 4
$deck = Array.new
$player = Array.new
$pickup_2_count = 0
$pickup_4_count = 0
$skip_played = false
$reverse_played = false
$match_card = Hash.new
rounds = 1

#String.color_samples
#String.modes

#Initialize play
$player = player_info(max_num_players)
$deck = create_deck
deal_cards
$discard_pile = start_discard_pile
$match_card = $discard_pile.last
winner = false

#game on
while !winner
    display_table(rounds)
        turn
        end_turn
        winner = check_winner
        rounds += 1
        next_turn
end





#DEBUGGING##############################
# puts "player count: #{Player.player_count}"
#  puts "players to string #{player.to_s}"
#  Player.player_count.times do |i|
#      puts "Player name: #{player[i].name} type: #{player[i].type} diff: #{player[i].difficulty} hand: #{player[i].hand}"
#     i += 1
#  end  
# puts
# puts $deck.length
# puts "discard pile is #{discard_pile}"
 #DEBUGGING##############################







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
# if $player[0] hand array is empty, $player[0] is the winner
# if skip played, move next player in turn_order array to end
# if rev, reverse turn_order array
# if anycolor, ask player to choose color and assign to top_card_color
# if $player[0] hand array has only one card left output "ONE!"

# function Computer strategy hard?
# try to play color first, if more than one choice, choose the card with a number not repeated in the hand array, if has pickup_2, save till last card
# if no color, play same number
# if no color or number, play anycolor and change color to the color most prevelent in hand array