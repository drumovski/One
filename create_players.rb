#required by One.rb





# create profiles -eg  player_info[{type: "human", difficulty: "easy", name: "Blah"},{type: "computer", difficulty: "easy", name: "Blah"}
def create_players(num_human_players,num_computer_players)
    i = 1
    if num_human_players != 0     
        print "Please enter first players name: "
        name = gets.chomp
        $player << Human.new(name)
        (num_human_players-1).times do   
            print "Please enter next players name: "
            name = gets.chomp
            $player << Human.new(name)
            i += 1
        end
    end


    if num_computer_players != 0
        n = 1       
        num_computer_players.times do
            begin
               print "Enter difficulty level for Computer player #{n} (1:easy, 2:normal, 3:hard): "
               difficulty = gets.chomp
               validate_difficulty(difficulty)
            rescue InvalidDifficultyError => e
                puts e.message
            retry
            end
            difficulty = difficulty.to_i              
            $player << Computer.new(difficulty)
            n += 1
            i += 1
        end  
    end
return $player
end


# Determine number of players
def player_info(max_num_players)
        begin
        print "Please enter the number of human players (must be between 0 and #{max_num_players}): "
        num_human_players = gets.chomp
        verify = validate_number_of_players(num_human_players, max_num_players)
        rescue InvalidNumberPlayersError => e
            puts e.message
        retry
        end
        num_human_players = num_human_players.to_i
        $player = create_players(num_human_players,0)
     

        begin
        print "Please enter the number of computer players (must be between 0 and #{max_num_players}): "
        num_computer_players = gets.chomp
        validate_number_of_players(num_computer_players, max_num_players)
        rescue InvalidNumberPlayersError => e
            puts e.message
        retry
        end
        num_computer_players = num_computer_players.to_i
    
    create_players(0,num_computer_players)
return $player
end
