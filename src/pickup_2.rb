#required by one2

module Pickup2
    module_function

    def pickup_2_played?
        if player_array.last.last_action == "Pickup 2"
            if pickup_2_in_hand?
                if player_array[0].type == :computer
                    computer_play_pickup_2
                elsif player_array[0].type == :human
                end
            end
        end
    end

    def pickup_2_in_hand?
        player_array[0].cards.length.times do |i|
        end


    end

    def human_play_pickup_2
    end

    def computer_play_pickup_2
    end
end