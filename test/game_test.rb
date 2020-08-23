require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/game'

class ClassTest < Minitest::Test
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
    suits = %i[diamond club heart spade]

    assert_equal 52, game.big_deck.length
    assert_equal 26, game.player1.deck.cards.length
    assert_equal 26, game.player2.deck.cards.length
    suits.each do |suit|
      assert_equal 13, (game.big_deck.count { |card| card.suit == suit })
    end
    (2..10).each do |number|
      assert_equal 4, (game.big_deck.count { |card| card.rank == number })
      assert_equal 4, (game.big_deck.count { |card| card.value == number.to_s })
    end
    face_cards = %w[Jack Queen King Ace]
    face_cards.each do |face|
      assert_equal 4, (game.big_deck.count { |card| card.value == face })
    end
  end

  def test_it_can_create_players
    game = Game.new
    game.create_decks

    assert_equal 'Megan', game.player1.name
    assert_equal 'Aurora', game.player2.name
  end

  def test_it_can_display_turn_messages
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
    player1 = Player.new('Megan', deck1)
    player2 = Player.new('Aurora', deck2)
    turn = Turn.new(player1, player2)

    assert_equal 'Turn 1: Megan won 2 cards', game.turn_messages(turn)
  end

  def test_it_can_determine_winner
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
    game = Game.new
    game.create_decks
    game.player1.deck.cards.shift(26)
    game.player1.deck.cards << card1
    game.player2.deck.cards.shift(26)
    game.player2.deck.cards << card3
    game.run_turns

    assert_equal game.player1, game.determine_game_winner

    game = Game.new
    game.create_decks
    game.player1.deck.cards.shift(26)
    game.player1.deck.cards << card1
    game.player1.deck.cards << card2
    game.player1.deck.cards << card6
    game.player2.deck.cards.shift(26)
    game.player2.deck.cards << card4
    game.player2.deck.cards << card7
    game.player2.deck.cards << card8
    game.run_turns

    assert_equal game.player1, game.determine_game_winner
  end
end
