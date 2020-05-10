#required by one

module Pickup2
    module_function

    def pickup_2_human(player_array, deck, discard_pile)
        begin
            puts "and you have a pickup 2."
            puts "Choose pickup color (Y,B,R,G) or D (draw #{discard_pile.pickup_2_count} cards)"
            option = gets.chomp.downcase
            color = option[0]
            number = "Pickup 2"
            color = validate_color(color)
            if color == "Draw"
                draw_cards_pickup_2(player_array, deck, discard_pile)
                puts " #{player_array[0].name} chooses to pick up #{discard_pile.pickup_2_count} cards"
                return
            end
            validate_card_in_hand(color, number, player_array[0])
        rescue InvalidColorError => e
          puts e.message
        retry  
        rescue InvalidCardInHandError => e
            puts e.message
        retry
        end
        player_array[0].play_card(discard_pile, color, "Pickup 2")
        return
    end

    def pickup_2_computer_1(player_array, deck, discard_pile)
        draw_cards_pickup_2(player_array, deck, discard_pile)
    end

    def pickup_2_computer_2(player_array, deck, discard_pile)
        color = false
        i = 0
        until color do
            if player_array[0].cards[i].number == "Pickup 2"
                color = player_array[0].cards[i].color
            end
            i += 1
        end
        player_array[0].play_card(discard_pile, color, "Pickup 2")
    end

    def pickup_2_computer(player_array, deck, discard_pile)
        if player_array[0].difficulty == 1
            pickup_2_computer_1(player_array, deck, discard_pile)
        else
            pickup_2_computer_2(player_array, deck, discard_pile)
        end
    end

    def draw_cards_pickup_2(player_array, deck, discard_pile)
        discard_pile.pickup_2_count.times do
            player_array[0].cards << deck.take_card
        end
        puts "#{player_array[0].name} picked up #{discard_pile.pickup_2_count} cards"
        discard_pile.pickup_2_count = 0
    end

    def pickup_2?(player_array, deck, discard_pile)
        if player_array.last.last_action == "Pickup 2" #last round pickup 2 was played?
            puts "A pickup 2 has been played"
            player_array.last.last_action = "Pickup 2 actioned"
            if player_array[0].has_number?("Pickup 2") != 0 #current player has a Pickup 2 in their hand?
                if player_array[0].type == :computer
                    pickup_2_computer(player_array, deck, discard_pile)
                    return true
                else 
                    pickup_2_human(player_array, deck, discard_pile)
                    return true
                end
            else
                draw_cards_pickup_2(player_array, deck, discard_pile)
                puts "Press enter to continue"
                gets.chomp
                return true
            end
        end
        return false
    end

end