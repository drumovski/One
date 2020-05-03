# frozen_string_literal: true

# required by one2.rb

module ComputerTurn
    module_function

    def computer_can_not_play(player, deck)
        puts "#{player.name} has no possible cards to play"
        puts 'Press enter to pick up from deck'
        gets.chomp
        player.cards << deck.take_card
        return false
    end

    def display_cards_can_play(cards, match_card, play_array)
        print 'Computer can play: '
        play_array.length.times do |i|
          print " |  #{play_array[i].color} #{play_array[i].number}  |".colorize(play_array[i].colorize)
        end
        puts
        puts '_______________________________________________________________________________________'
    end

    def computer_logic_display(player, match_card, deck, play_array)
        chosen_card = play_array.sample
        puts "computer chose #{chosen_card.color} #{chosen_card.number} at random"
        puts "press enter to continue"
        gets
        return chosen_card
    end

    def get_chosen_card(player, match_card, deck, play_array)
        case player.difficulty
        when 1
            chosen_card = computer_logic_display(player, match_card, deck, play_array)
            
        when 2
            chosen_card = computer_logic_display(player, match_card, deck, play_array)
        when 3
            chosen_card = computer_logic_display(player, match_card, deck, play_array)
        end

        chosen_card
    end

      def computer_play_card(player, match_card, deck, discard_pile, play_array)
        display_cards_can_play(player.cards, match_card, play_array)
        chosen_card = get_chosen_card(player, match_card, deck, play_array)
        if chosen_card != false # Player did not draw a card
          player.play_card(discard_pile, chosen_card.color, chosen_card.number) # current player plays a card
          return true
        else
          return false
        end
      
    end



      
end