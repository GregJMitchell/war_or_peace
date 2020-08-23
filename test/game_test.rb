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
        assert_nil game.player1
        assert_nil game.player2
        assert_equal 0, game.turn_count

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
    
    def test_it_can_run_turns
        game = Game.new
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)
        card3 = Card.new(:heart, '9', 9)
        card4 = Card.new(:diamond, 'Jack', 11)
        card5 = Card.new(:heart, '8', 8)
        card6 = Card.new(:diamond, 'Queen', 12)
        card7 = Card.new(:heart, '3', 3)
        card8 = Card.new(:diamond, '2', 2)
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card3, card4, card6, card7])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn = Turn.new(player1, player2)

        assert_equal turn.spoils_of_war, game.turn_messages(turn)
    end

    def it_can_determine_winner
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)
        card3 = Card.new(:heart, '9', 9)
        card4 = Card.new(:diamond, 'Jack', 11)
        card5 = Card.new(:heart, '8', 8)
        card6 = Card.new(:diamond, 'Queen', 12)
        card7 = Card.new(:heart, '3', 3)
        card8 = Card.new(:diamond, '2', 2)
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card3, card4, card6, card7])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn = Turn.new(player1, player2)
        game.turn_messages(turn)

        assert_equal player1, game.it_can_determine_winner
    end
end