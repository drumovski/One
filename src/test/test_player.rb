require 'test/unit'
require_relative '../classes/player'
require_relative '../classes/hand'

class PlayerTest < Test::Unit::TestCase
    
    def test_player_name
        player1 = Human.new("Harry")
        assert_equal(player1.name, "Harry")
    end





end

