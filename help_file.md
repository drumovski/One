### Help File:

##### Installation Instructions:

1. Copy the One2 repository into a local directory from GitHub here: https://github.com/drumovski/One2. For instructions on downloading a repository, see here: https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository
2. this is what you should end up with if running from the terminal: "git clone https://github.com/drumovski/One2.git"
3. Ruby Language must be installed. For help installing Ruby, see here: https://www.ruby-lang.org/en/downloads/
4. In the terminal, navigate to the One2 directory "cd One2".
5. You may need to change the permissions of the one_install script. Do this by typing chmod u+x one_install && './one_install.sh' in the terminal. This only needs to be done once.
6. When running the game in future, just type ./ruby one2.rb from the **src directory**. For a list of arguments, see below.



##### System/Hardware requirements:

Very light computational hardware requirements. Ability to run terminal applications.

##### Dependencies:

Gems included in this program - 

1. Colorize
2. TTY-Font
3. TTY-Box

##### Arguments when starting game:

eg. ruby ./one2.rb -mp 8

possible arguments:

​      ''-h" help

​      '-s' skip splash screen

​      '-mp' change maximum players from 4 to a value specified eg -mp 8

​      Warning, changing the maximum value to an invalid number or to a number too high (10+) will cause the game to behave erratically



### List of Features:

##### Classes: 

###### Card class - variables: @color and @number. Number variable will include 0-9 for basic numbers but strings "reverse", "skip", "pickup 2" and "pickup 4" for action cards. The reason for this is to be able to compare the number variable easily when trying to match the discard pile to the players chosen card without additional code for a separate variable such as "type_of_card" Each card will be an instance.

###### Deck class - this will be a single instance "deck" containing an array "@cards" containing card objects 

###### Deck class methods - separate methods for creating the different parts of the deck - basic cards, actions cards, special cards. 

Fill deck - calls the separate methods for creating the deck. 

Replace_deck - if the deck runs out during play, this will turn the discard pile into a new deck. 

Take_card - pops a card from the end of the @cards array.

###### DiscardPile Class - this will be a single instance "discard_pile" similar to deck but starting empty.

###### Discard pile methods - 

Reset_discard_pile - starts the discard pile with a basic color card.

###### Player class - Each player will have an instance with variables: @name, @type (for future revision to include human or computer) @last_action (for ease of use when determining what happened on the previous turn in case of skip or reverse etc) and @hand - an array of the card instances that player is holding. Contains a @@player_count class variable to keep track of the number of players.

###### Player_class methods - 

Play_card - checks chosen card color and number against @hand colour and number and finds the correct card to play from the array. Once found, it removes it from the @hand and adds it to the discard_pile. 

##### Structure:

The main structure will be broken up into 5 main areas:

1. Splash screen
2. Initialization
3. Pre turn
4. Turn
5. End turn

The pre turn, turn and end turn will loop through until a winner is determined and then return to the splash screen where the user can start a new game.

##### Splash Screen:

Will contain a welcome screen with the option to view the rules, start a new game, or quit the game. The entered option will have error handling to ensure no invalid responses can be entered. This screen will also be displayed after the game finishes. I will contain this screen and it's functionality in a module

##### Initialization:

Player creation - user will enter number of players, validated against a maximum_number_of_players variable. Then prompted to enter each players name. This info will be stored in each player instance. Each player instance will then be stored in player_array. This will be used to keep track of turn order.

Deck creation - The deck will be created with card instances  each with color and number variables stored in an array - deck. See card class above.  It will then be randomised.

Discard pile creation - this is created as an empty array to hold all discarded card objects. The top card will be assigned to match_card for validation on the card the player is allowed to play. It must match a color or number. The top card will be taken from the deck to start the pile but another one chosen (if it is an action card - reverse, skip etc) until it is a basic color card.

Deal cards - Each player in player_array will be 'dealt' (card added to their hand and deleted from deck) 7 cards. This will be achieved by looping through the player_array.

##### Pre turn:

This will primarily used to check what happened the  previous round. 

Clear_screen method - this simply clears the screen from the previous player so the new player does not see the previous players hand. It will also print a message informing the player if they are about to miss their turn and why - via a message passed to it by the pickup 2, pickup 4, skip and reverse methods.

Miss_turn check - If a skip, reverse, pickup 2, or pickup 4 is played, the player misses their turn. This is checked by checking the last_action variable of the last person in the player_array. 

Pickup 2 - 2 cards are passed from the deck to the players hand via the player method - take_card. A message is also returned and passed to the player via clear_screen method that they miss their turn and pick up 2 cards.

Pickup 4 - 4 cards are passed from the deck to the players hand via the player method - take_card. A message is also returned and passed to the to the player via clear_screen method that they miss their turn and pick up 4 cards.

Reverse method - reverses the player_array via the built in method reverse. A message is also returned and passed to the player via clear_screen method that they miss their turn and a reverse was played.

Skip method - skips the current in the player array by player_array. This method doesn't do anything other than  return to the player via clear_screen method that they miss their turn and a skip was played. This is because any of these methods will skip the player having their turn by bypassing the turn method.

##### Turn:

Display_table - this method displays the players name, number of cards any opponents have left in their hand, cards left in the deck, and cards in the players hand.

Display_cards_can_play - matches the match card to all the cards in the players hand and stores them in play_array then displays them

Can_not_play - determines if the player can play any cards and skips the gets_chosen_card method if so. User then only needs to press enter to pick up a card

Pick_up_card - transfers a card from the deck via take_a_card method in deck class and adds it to players hand. Then deletes it from the deck.

Get_chosen_card - Asks for user to enter their chosen card to play. For expediency of play I abbreviated the valid inputs. See user interaction and experience below for details. The choice is then validated 3 times. Once for valid choice, twice to check if the card is in the players hand, and lastly to check if the card matches the match card and is valid to play. 

##### End turn:

Choose_wild_color - If a wild card is chosen, the player is prompted to enter the colour to continue play. The options will be R, Y, B, G. This will be validated to only have those options. The color of the match card will then be changed to the correct color.

Check_winner - This will check to see if the current player in the player_array has no cards left in their hand. If so, a winner screen with the players name will be displayed. I will include a gem to improve the look of the winner screen. Once a winner is found, this will end the pre_turn, turn and end_turn loop.

Next_player - this will move the current player in the player_array to the end so the next person in line has their go next.

Deck_swap - If the deck runs out of cards, this method will replace the deck with the discard_pile, reset the discard pile and randomise the deck.

##### Cmd arguments:

When starting the program, the user has 3 options entered in via cmd line arguments

-h - (help) displays the options available to play

-s (skip splash_screen) skips the splash screen for faster game loading

-mp (maximum_player, value) changes the value of the maximum player from 4 (default) to an entered value. Note, this can break the game if the number entered is too high (above 12 or so) as there will not be enough cards to deal to everyone and play the game.

