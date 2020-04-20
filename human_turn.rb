#required by One.rb


def choose_wild_color_human
    begin
    print "Choose color for wild card (Y, B, R, G):"
    choice = gets.chomp.downcase
    color = validate_basic_color(choice)
    rescue InvalidColorError => e
        puts e.message
    retry
    end
    $match_card = {:color=>color, :number=>"Card", :colorize=>color_card(color)}
end


def pickup_2_human(count)
    begin
        puts "A pickup 2 has been played and you have #{count} pickup 2."
        puts "Choose a color (Y,B,R,G) or D (draw #{2*$pickup_2_count} cards)"
        option = gets.chomp.downcase
        color = option[0]
        number = "Pickup 2"
        color = validate_color(color)
        if color == "Draw"
            puts " #{$player[0].name} chooses to pick up #{2*$pickup_2_count} cards"
            $player[0].take_a_card(2*$pickup_2_count).sort_hand
            return
        end
        validate_card_in_hand(color, number)
    rescue InvalidColorError => e
      puts e.message
    retry  
    rescue InvalidCardInHandError => e
        puts e.message
    retry
    end
    $player[0].play_card(color, "Pickup 2")
end


def pickup_4_human(count)
    puts "A pickup 4 has been played and you have #{count} pickup 4."
    puts "Choose D to draw #{4*$pickup_4_count} cards or any other key to play Pickup 4)"
    option = gets.chomp.downcase
    number = "Pickup 4"
    if option[0] == "d"
        puts " #{$player[0].name} chooses to pick up #{4*$pickup_4_count} cards"
        $player[0].take_a_card(4*$pickup_4_count).sort_hand
        return
    end
$player[0].play_card("Wild", "Pickup 4")
end

def human_turn
    play_array = $player[0].can_play_array($match_card[:color], $match_card[:number])
    if play_array.empty?
        puts "#{$player[0].name} has no possible cards to play"
        puts "Enter any key to pick up from deck"
        option = gets.chomp
        $player[0].take_a_card(1).sort_hand
        return
    else
        begin
            print "Cards you can play: " 
            play_array.length.times do |i|
                print "|  #{play_array[i][:color].colorize(play_array[i][:colorize])} #{play_array[i][:number].to_s.colorize(play_array[i][:colorize])}  |"
                i += 1
            end
            puts
            puts "Enter R, B, Y, G followed by a number(0-9), R-Reverse, S-Skip or P2-Pickup 2. Eg: to play a Red 7, enter R7"
            puts "Enter Wi for Wild, WP4 for Wild Pickup_4 "
            puts "Enter D to pick up from the deck"
            puts "What card would you like to play? "
            option = gets.downcase
            color = option[0]
            number = option[1, 2].strip
            color = validate_color(color)
            if color == "Draw"
                puts "#{$player[0].name} chooses to pick up a card"
                $player[0].take_a_card(1).sort_hand
                return
            end
            number = validate_number(number)
            validate_card_in_hand(color, number)
            validate_card_matches_discard(color, number, $match_card)
        rescue InvalidColorError => e
            puts e.message
            retry
        rescue InvalidNumberError => e
            puts e.message
            retry
        rescue InvalidCardInHandError => e
            puts e.message
            retry
        rescue InvalidCardMatchError => e
            puts e.message
            retry
        end
    $player[0].play_card(color, number)
    end
end