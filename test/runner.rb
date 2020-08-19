require './lib/card'
require './lib/deck'

card1 = Card.new(:diamond, 'Queen', 12)
card2 = Card.new(:spade, '3', 3)
card3 = Card.new(:heart, 'Ace', 14)
cards = [card1, card2, card3]
deck = Deck.new(cards)
deck.cards
deck.high_ranking_cards
deck.percent_high_ranking
deck.remove_card
deck.cards
deck.high_ranking_cards
deck.percent_high_ranking
card4 = Card.new(:club, '5', 5)



require "pry";binding.pry
