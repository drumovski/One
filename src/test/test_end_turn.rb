require 'test/unit'
require 'tty-font'
require 'colorize'
require_relative '../classes/deck'
require_relative '../classes/card'
require_relative '../classes/hand'
require_relative '../classes/player.rb'
require_relative '../end_turn.rb'

class EndTurnTests < Test::Unit::TestCase
    
    def test_winner
        player_array = []
        player_array << Human.new("John")
        winner = EndTurn::check_winner(player_array[0])
        assert_true(winner)
    end
end