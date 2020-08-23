require './lib/deck'
require './lib/card'
require './lib/player'
require './lib/turn'

class Game
  attr_reader :big_deck, :deck1, :deck2, :player1, :player2, :turn_count
  def initialize
    @big_deck = []
    @deck1 = deck1
    @deck2 = deck2
    @player1 = player1
    @player2 = player2
    @turn_count = 0
  end

  def create_decks
    suits = %i[diamond club heart spade]

    suits.each do |suit|
      2.upto(14) do |number|
        if number < 11
          @big_deck << Card.new(suit, number.to_s, number)
        elsif number == 11
          @big_deck << Card.new(suit, 'Jack', number)
        elsif number == 12
          @big_deck << Card.new(suit, 'Queen', number)
        elsif number == 13
          @big_deck << Card.new(suit, 'King', number)
        elsif number == 14
          @big_deck << Card.new(suit, 'Ace', number)
        end
      end
    end
    shuffle_deck
  end

  def shuffle_deck
    @big_deck.shuffle!
    @deck1 = Deck.new(@big_deck[0..25])
    @deck2 = Deck.new(@big_deck[26..52])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)
  end

  def start_screen
    puts 'Welcome to War! (or Peace) This game will be played with 52 cards.'
    puts 'The players today are Megan and Aurora.'
    puts "Type 'GO' to start the game!"
    puts '------------------------------------------------------------------'
  end

  def turn_messages(turn)
    case turn.type
    when :basic, :war
      winner = turn.winner
      @turn_count += 1
      turn.pile_cards
      turn.award_spoils(winner)
      p "Turn #{@turn_count}: #{winner.name} won #{turn.spoils_of_war.length} cards"
    when :mutually_assured_destruction
      winner = turn.winner
      @turn_count += 1
      turn.pile_cards
      spoils = turn.spoils_of_war.length
      turn.award_spoils(winner)
      p "Turn #{@turn_count}: *mutually assured destruction* #{spoils} cards removed from play"
    end
  end

  def determine_game_winner
    if @player1.has_lost?
      @player2
    elsif @player2.has_lost?
      @player1
    end
  end

  def run_turns
    while @player1.has_lost? == false && @player2.has_lost? == false
      break if @player1.has_lost? || @player2.has_lost?

      if @turn_count <= 999_999
        turn = Turn.new(@player1, @player2)
        turn_messages(turn)
      else
        return puts '---- DRAW ----'
      end
    end
    winner = determine_game_winner
    puts "*~*~*~* #{winner.name} has won the game! *~*~*~*"
  end

  def start
    start_screen
    input = gets.chomp
    if input.capitalize == 'Go'
      create_decks
      run_turns
    else
      p 'Invalid Input'
      start
    end
  end
end
