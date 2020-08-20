require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/card'
require './lib/deck'

class PlayerTest <Minitest::Test
  def setup
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)
    player = Player.new("Clarisa", deck)
  end
  def test_it_exists
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)
    player = Player.new("Clarisa", deck)

    assert_instance_of Player, player
  end
  def test_it_has_readable_attributes
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)
    player = Player.new("Clarisa", deck)

    assert_equal "Clarisa", player.name
    assert_equal [card1, card2, card3], player.deck.cards
  end
  def test_it_can_detect_loss
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)
    player = Player.new("Clarisa", deck)
    deck.remove_card
    deck.remove_card
    deck.remove_card

    assert_equal true, player.has_lost?
  end
end
