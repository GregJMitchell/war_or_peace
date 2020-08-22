require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/game'

class ClassTest <Minitest::Test
    def setup
        
    end

    def test_it_has_readable_attributes
        game = Game.new

        assert_instance of Game, game
    end
end