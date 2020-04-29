require 'test/unit'
require_relative 'One'

class NumberOfPlayersTest < Test::Unit::TestCase
    
    def test_integer
        assert_(2, num_human_players)
    end

    def test_exceed_max_players
    end


end

