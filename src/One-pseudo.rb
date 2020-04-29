# ONE

# Display rules

# function create deck
# create array of 108 cards called deck
# each containing a hash card {colour: red, number: 7}
# either [colour, number] or [colour, skip] [colour, rev] [colour, pickup_2]
# or special cards -
# [anycolour, null] or [anycolour, pickup_4]

# Determine number of players and make array turn_order [player_1, player_2, etc]
# create profiles - player_1_info = hash {type: human/computer, difficulty: easy}


# Difficulty?

# function Deal Cards
# Take cards (each hash out of the deck array and into the hands arrays (1 hand array eg player_1_hand for each player containing 7 random card hashes)
# example - player_1_hand = [{red, 7},{blue, 5}, {anycolour, null}, {yellow, pickup_2}, {red, 0}
# take random valid card from deck array and use it to start the discard array
# top_card_number = number from card chosen
# top_card_colour = colour from card chosen

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




