#required by one2

module Pickup4
    module_function

    def pickup_4_human(player_array, deck, discard_pile)
        begin
            puts "and you have a pickup 4."
            puts "Choose W for Wild or D (draw #{discard_pile.pickup_4_count} cards)"
            option = gets.chomp.downcase
            color = option[0]
            number = "Pickup 4"
            color = validate_color(color)
            if color == "Draw"
                draw_cards_pickup_4(player_array, deck, discard_pile)
                puts " #{player_array[0].name} chooses to pick up #{discard_pile.pickup_4_count} cards"
                return false
            end
            validate_card_in_hand(color, number, player_array[0])
        rescue InvalidColorError => e
          puts e.message
        retry  
        rescue InvalidCardInHandError => e
            puts e.message
        retry
        end
        player_array[0].play_card(discard_pile, color, "Pickup 4")
        return true
    end

    def pickup_4_computer(player_array, deck, discard_pile)
    end

    def draw_cards_pickup_4(player_array, deck, discard_pile)
        discard_pile.pickup_4_count.times do
            player_array[0].cards << deck.take_card
        end
        puts "#{player_array[0].name} picked up #{discard_pile.pickup_4_count} cards"
        discard_pile.pickup_4_count = 0
    end

    

    def pickup_4_played(player_array, deck, discard_pile)
        if player_array[0].has_number?("Pickup 4") #current player has a Pickup 4 in their hand?
            if player_array[0].type == :computer
                return pickup_4_computer(player_array, deck, discard_pile)
            else 
                return pickup_4_human(player_array, deck, discard_pile)
            end
        else
            draw_cards_pickup_4(player_array, deck, discard_pile)
            puts "Press enter to continue"
            gets.chomp
            return false
        end
    end

        def pickup_4_played_before(player_array)
            if player_array.last.last_action == "Pickup 4" #last round pickup 4 was played?
                puts "A pickup 4 has been played"
                player_array.last.last_action = "Pickup 4 actioned"
                return true
            end
            return false
        end
end