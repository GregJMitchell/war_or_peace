require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/card'
require './lib/deck'
require './lib/turn'

class TurnTest <Minitest::Test
    def test_it_exists
        player1 = Player.new("Megan", Deck.new([]))
        player2 = Player.new("Aurora", Deck.new([]))
        turn = Turn.new(player1, player2)

        assert_instance_of Turn, turn
    end

    def test_has_readable_attributes
        player1 = Player.new("Megan", Deck.new([]))
        player2 = Player.new("Aurora", Deck.new([]))
        turn = Turn.new(player1, player2)

        assert_equal player1, turn.player1
        assert_equal player2, turn.player2
        assert_equal [], turn.spoils_of_war
    end

    def test_it_can_find_term_type
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)

        deck1 = Deck.new([card1, card1, card1])
        deck2 = Deck.new([card2, card2, card2])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn = Turn.new(player1, player2)

        assert_equal :basic, turn.type

        deck1 = Deck.new([card1, card2, card1])
        deck2 = Deck.new([card1, card2, card2])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn2 = Turn.new(player1, player2)
        assert_equal :war, turn2.type

        deck1 = Deck.new([card1, card2, card1])
        deck2 = Deck.new([card1, card2, card1])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn3 = Turn.new(player1, player2)

        assert_equal :mutually_assured_destruction, turn3.type
    end

    def test_it_can_find_winner
        #basic turn
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)
        deck1 = Deck.new([card1, card2, card1])
        deck2 = Deck.new([card2, card2, card1])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn = Turn.new(player1, player2)

        assert_equal player1, turn.winner
        
        #war turn
        deck1 = Deck.new([card1, card2, card2])
        deck2 = Deck.new([card1, card2, card1])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn2 = Turn.new(player1, player2)

        assert_equal player2, turn2.winner

        #MAD turn
        deck1 = Deck.new([card1, card1, card1])
        deck2 = Deck.new([card1, card1, card1])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn3 = Turn.new(player1, player2)

        assert_equal 'No Winner', turn3.winner
    end

    def test_it_can_pile_cards
        #basic game
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
        turn.pile_cards

        assert_equal [card1, card3], turn.spoils_of_war

        #war game
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn2 = Turn.new(player1, player2)
        turn2.pile_cards

        assert_equal [card1, card4, card2, card3, card5, card6], turn2.spoils_of_war

        #MAD game
        card6 = Card.new(:diamond, '8', 8)
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn3 = Turn.new(player1, player2)
        turn3.pile_cards

        assert_equal [card8], player1.deck.cards
        assert_equal [card7], player2.deck.cards
    end

    def test_can_it_award_spoils
        #basic game
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
        winner = turn.winner
        turn.pile_cards
        turn.award_spoils(winner)
        
        assert_equal [card2, card5, card8, card1, card3], player1.deck.cards

        #war game
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn2 = Turn.new(player1, player2)
        winner = turn2.winner        
        turn2.pile_cards
        
        turn2.award_spoils(winner)
        
        assert_equal [card7,card1, card4, card2, card3, card5,card6], player2.deck.cards

        #MAD game
        deck1 = Deck.new([card1, card2, card5, card8])
        card6 = Card.new(:diamond, '8', 8)
        deck2 = Deck.new([card4, card3, card6, card7])
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        turn3 = Turn.new(player1, player2)
        winner = turn3.winner
        turn3.pile_cards
        turn3.award_spoils(winner)

        assert_equal [card8], player1.deck.cards
        assert_equal [card7], player2.deck.cards
    end
end