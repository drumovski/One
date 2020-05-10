# frozen_string_literal: true

# required by one.rb

module ComputerTurn
    module_function

    def computer_can_not_play(player_array, deck)
        # puts "#{player_array[0].name} has no possible cards to play"
        # puts 'Press enter to pick up from deck'
        # gets.chomp
        player_array[0].cards << deck.take_card
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

    def computer_logic_display(match_card, deck, play_array)
        chosen_card = play_array.sample
        puts "computer chose #{chosen_card.color} #{chosen_card.number} at random"
        puts "press enter to continue"
        gets
        return chosen_card
    end

    def number_different_colors(player, arr)
        colors = player.color_count(arr)
        num_diff_colors = 0
        colors.each  do |col, num| 
            if num != 0
                num_diff_colors +=1
            end
        end
        num_diff_colors
    end

    # def matching_number(number, player)
    #     if player.has_number?(number) > 1
    #         return player.has_number?(number)
    # end

    def card_score(player_array, card, play_array)
        basic_score = 70
        skip_score = 60
        reverse_score = 60
        pickup_2_score = 40
        pickup_4_score = 20
        wild_score = 30
        case card.number
        when "Skip"
            if player_array.length <= 2
                card.score = skip_score - player_array[0].has_number?("Skip") - 10
            else
                card.score = skip_score - player_array[0].has_number?("Skip")
            end
        when "Reverse"
            if player_array.length <= 2
                card.score = reverse_score - player_array[0].has_number?("Reverse") - 10
            else
                card.score = reverse_score - player_array[0].has_number?("Reverse")
            end
        when "Pickup 2"
            if player_array[1].cards.length < 3
                card.score = pickup_2_score + 40
            else
                card.score = pickup_2_score + player_array[0].has_number?("Pickup 2")
            end
        when "Pickup 4"
            num_basic_colors_can_play = number_different_colors(player_array[0], play_array)
            num_diff_colors = number_different_colors(player_array[0], player_array[0].cards)          
            if player_array[1].cards.length < 3 #next opponent has less than 3 cards
                card.score = pickup_4_score + 70
            elsif num_basic_colors_can_play == 0 && play_array.length >= num_diff_colors #only wild can play && wild outnumber different colors
                card.score = pickup_4_score + 70
            elsif player_array[0].difficulty == 3 && num_basic_colors_can_play == 0 && play_array.length < num_diff_colors #only wild can play && different colors outnumber wild
                return false
            else
                card.score = pickup_4_score
            end
        when "Card"
            num_basic_colors_can_play = number_different_colors(player_array[0], play_array)
            num_diff_colors = number_different_colors(player_array[0], player_array[0].cards) 
            if player_array[0].difficulty == 3 && num_basic_colors_can_play == 0 && play_array.length < num_diff_colors #only wild can play && different colors outnumber wild
                return false
            elsif num_basic_colors_can_play == 0 && play_array.length >= num_diff_colors #only wild can play && wild outnumber different colors
                card.score = wild_score + 70
            elsif player_array[1].cards.length == 1 && player_array[1].last_action == "Wild" #next player has only 1 card left and played a wild last turn
                card.score = wild_score + 70
            else
                card.score = pickup_4_score
            end
        else
            #Card is basic
            card.score = basic_score - player_array[0].has_number?(card.number)
        end
        return card.score
    end

    def computer_1(player_array, match_card, deck, play_array)
        chosen_card = play_array[0]
        play_array.length.times do |i|
            play_array[i].score = card_score(player_array, play_array[i], play_array)
            # puts "score for #{play_array[i].color} #{play_array[i].number} is #{play_array[i].score}"
            if chosen_card.score >  play_array[i].score
                chosen_card = play_array[i]
            end
        end
        # puts "playing #{chosen_card.color} #{chosen_card.number}"
        chosen_card
    end
    
    def computer_3(player_array, match_card, deck, play_array)
        #if Opponent played a wild 
        # num_diff_colors = number_different_colors(player_array[0], player_array[0].cards)
        # num_basic_colors_can_play = number_different_colors(player_array[0], play_array)
        
        chosen_card = play_array[0]
        play_array.length.times do |i|
            play_array[i].score = card_score(player_array, play_array[i], play_array)
            if play_array[i].score == false
                # puts "#{player_array[0].name} chooses to pick up a card"
                player_array[0].cards << deck.take_card
                return false
            end
            # puts "score for #{play_array[i].color} #{play_array[i].number} is #{play_array[i].score}"
            if chosen_card.score <  play_array[i].score
                chosen_card = play_array[i]
            end
        end
        # puts "playing #{chosen_card.color} #{chosen_card.number}"
        chosen_card
    end


    def get_chosen_card(player_array, match_card, deck, play_array)
        case player_array[0].difficulty
        when 1
            chosen_card = computer_1(player_array, match_card, deck, play_array)
            
        when 2
            # chosen_card = computer_logic_display(match_card, deck, play_array)
            chosen_card = play_array.sample
        when 3
            chosen_card = computer_3(player_array, match_card, deck, play_array)
            
        end
        chosen_card
    end

    def computer_play_card(player_array, match_card, deck, discard_pile, play_array)
        # display_cards_can_play(player_array[0].cards, match_card, play_array)
        chosen_card = get_chosen_card(player_array, match_card, deck, play_array)
        if chosen_card != false # Player did not draw a card
          player_array[0].play_card(discard_pile, chosen_card.color, chosen_card.number) # current player plays a card
          return true
        else
          return false
        end
    
    end



      
end