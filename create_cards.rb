#required by One.rb


def create_colors_basic (color, colorize)
    #add a single "0" number to the color
    $deck.push({color: color, number: 0, colorize: colorize})
    i = 1
    9.times do
        #add two basic color cards to the deck numbered 1..9
        2.times {$deck.push({color: color, number: i, colorize: colorize})}       
        i += 1
    end
    return $deck    
end

def create_colors_special(color, colorize)
    #add the special color cards to the deck
    2.times {$deck.push({color: color, number: "Skip", colorize: colorize})}
    2.times {$deck.push({color: color, number: "Reverse", colorize: colorize})}
    2.times {$deck.push({color: color, number: "Pickup 2", colorize: colorize})}
return $deck
end

def create_wild_cards(colorize)
    4.times {$deck.push({color: "Wild", number: "Pickup 4", colorize: colorize})}
    3.times {$deck.push({color: "Wild", number: "Card", colorize: colorize})}
    return $deck
end

def create_custom_cards(colorize)
    $deck.push({color: "Wild", number: "Exchange", colorize: colorize})
    return $deck
end

def create_deck
    # create array of cards called deck
    puts "Creating deck"
    create_colors_basic("Blue", :light_blue)
    create_colors_basic("Red", :light_red)
    create_colors_basic("Yellow", :light_yellow)
    create_colors_basic("Green", :light_green)
    create_colors_special("Blue", :light_blue)
    create_colors_special("Red", :light_red)
    create_colors_special("Yellow", :light_yellow)
    create_colors_special("Green", :light_green)
    create_wild_cards(:magenta)
 #  create_custom_cards(:magenta) #may be implemented at a later stage
    puts "Created deck with #{$deck.length} cards"
    puts "Shuffling deck"
    $deck = $deck.shuffle
    return $deck
end


def deal_cards
    #Deal 7 cards from the deck to each player
    7.times do 
       Player.player_count.times do |i|
           $player[i].take_a_card(1).sort_hand
           i += 1
       end 
    end
end

def start_discard_pile
    #Get one valid card (not wild or skip or pickup) from deck and start the discard pile
    $discard_pile = Array.new
    $discard_pile << $deck.pop
    while $discard_pile[0][:color] == "wild" or $discard_pile[0][:number].is_a? String do
       $deck.unshift($discard_pile.pop)
       $discard_pile << $deck.pop     
    end
    return $discard_pile
end