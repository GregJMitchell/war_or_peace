require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/card'
require './lib/deck'

class PlayerTest <Minitest::Test
  def test_it_exists
    deck = Deck.new([])
    player = Player.new("", deck)

    assert_instance_of Player, player
  end

  def test_it_has_readable_attributes
    deck = Deck.new([])
    player = Player.new("Clarisa", deck)

    assert_equal "Clarisa", player.name
    assert_equal deck, player.deck
  end

  def test_it_can_detect_loss
    card1 = Card.new(:diamond, 'Queen', 12)
    cards = [card1]
    deck = Deck.new(cards)
    player = Player.new("Clarisa", deck)

    assert_equal false, player.has_lost?
    
    deck.remove_card

    assert_equal true, player.has_lost?
  end
end
