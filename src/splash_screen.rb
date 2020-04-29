# frozen_string_literal: true

# required by one2.rb

module SplashScreen
  module_function

  def rules
    puts 'One Rules:'.colorize(:green)
    puts '107 cards as follows:'
    puts '19 Blue card 0-9'
    puts '19 Blue card 0-9'
    puts '19 Green cards 0-9 '
    puts '19 Red cards 0-9 '
    puts '19 Yellow cards 0-9'
    puts '8 Pickup 2 cars – 2 each in blue, green, red and yellow '
    puts '8 Reverse cards – 2 each in blue, green, red and yellow'
    puts '8 Skip cards – 2 in each blue green red and yellow'
    puts '4 Wild draw 4 cards'
    puts '3 Wild cards'
    puts
    puts 'Object of the game: be the first player to get rid of all your cards.'
    puts 'Set up'
    puts 'Each player is dealt 7 cards.'
    puts 'The remainder of the deck forms a draw pile.'
    puts 'The top card of the draw pile is turned over to begin a discard pile.'
    puts 'If any of the action cards are turned over to start the discard pile, they are returned to the draw pile until'
    puts 'a basic colour card is drawn (0 - 9).'
    puts
    puts 'Each turn, the player must match a card from their hand to the card on the top of the discard pile.'
    puts 'Example: If the card on the discard pile is a red 7, the player must put down a red card or any colour 7.'
    puts 'Alternatively the player can put down a wildcard.'
    puts "If you don't have a card that matches the one on the discard pile, you must take a card from the draw pile and"
    puts 'the play is moved to the next player.'
    puts 'You may also choose not to play a playable card from your hand. If so, you must draw a card from the draw pile.'
    puts
    puts 'Functions of action cards'
    puts 'Pickup 2 card – when you play this card, the next player must draw 2 cards and miss their tern. May only be'
    puts 'played on a matching colour or on another Pickup 2 card.'
    puts 'Reverse card – when you play this card, the direction of play reverses.'
    puts 'The next player goes to the end of the turn order. My only be played on a matching colour, or on another reverse card.'
    puts 'Skip card – when you play this card the next player is skipped and loses their turn. May only be played on a matching'
    puts 'colour or on another skip card.'
    puts 'Wildcard – when you play this card you get to choose the colour that continues play - any colour may be chosen'
    puts 'including the colour in play before the wildcard was laid down. You may play a wildcard on your turn even if you have another'
    puts 'playable card in your hand.'
    puts 'Wild draw 4 card – when you play this card you get to choose the colour that continues play plus the next player must'
    puts 'draw 4 cards from the draw pile and lose their turn.'
    puts 'Once a player has no cards left they are determined to be the winner and that is the end of the game.'
    puts 'Note: it is not necessary to indicate that you only have one card left as in the original game of UNO. However, players'
    puts 'will be able to see how many cards their opponents have and will be warned if they only have one card remaining.'
    puts
    puts
    puts 'press enter to return to main screen'
    gets
  end

  def splash_screen_choice
    choice = 2
    while choice == 2
      system 'clear'
      puts ' _______  __    _  _______  '
      puts '|       ||  |  | ||       | '
      puts '|   _   ||   |_| ||    ___| '
      puts '|  | |  ||       ||   |___  '
      puts '|  |_|  ||  _    ||    ___| '
      puts '|       || | |   ||   |___  '
      puts '|_______||_|  |__||_______| '
      puts
      puts 'Welcome to ONE - a card game based on UNO'
      puts
      begin
        puts '1) Start a new game'
        puts '2) View the rules'
        puts '3) Quit'
        print 'Please make a choice (1, 2, or 3): '
        choice = gets.chomp.to_i
        validate_start_choice(choice)
      rescue InvalidStartChoice => e
        puts e.message
        retry
      end
      case choice
      when 2
        rules
      when 1
        return true
      when 3
        return false
      end
    end
  end
end
