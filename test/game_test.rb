require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/game'

class ClassTest <Minitest::Test
    def setup
        game = Game.new
    end

    def test_it_exists
        game = Game.new

        assert_instance_of Game, game
    end
    
    def test_has_readable_attributes
        game = Game.new

        assert_equal [], game.big_deck
        assert_nil game.deck1
        assert_nil game.deck2
    end

    def test_it_can_create_deck
        game = Game.new
        game.create_decks

        refute_equal [], game.big_deck 
    end

    def test_it_can_create_players
        game = Game.new
        game.create_decks

        assert_equal "Megan", game.player1.name
        assert_equal "Aurora", game.player2.name
    end
end