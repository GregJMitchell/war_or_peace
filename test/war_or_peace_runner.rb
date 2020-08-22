#require 'minitest/autorun'
#require 'minitest/pride'
require './lib/player'
require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/game'

game = Game.new

# game.create_decks
# puts game.big_deck.length
game.start