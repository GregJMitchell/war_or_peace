class Game
    attr_reader :big_deck, :deck1, :deck2
    def initialize
        @big_deck = []
        @deck1 = deck1
        @deck2 = deck2
    end

    def create_decks
        suits = [:diamond, :club, :heart, :spade]

        suits.each do |suit|
            2.upto(14) do |number|
                if number < 11
                    @big_deck << Card.new(suit, "#{number}", number)
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
        @big_deck.shuffle
        @deck1 = Deck.new@big_deck[0..25]
        @deck2 = Deck.new@big_deck[26..52]
    end

    def create_players
        player1 = Player.new("Megan", @deck1)
        player2 = Player.new("Aurora", @deck2)
    end

    def start_screen
        puts "Welcome to War! (or Peace) This game will be played with 52 cards."
        puts "The players today are Megan and Aurora."
        puts "Type 'GO' to start the game!"
        puts "------------------------------------------------------------------"
    end

    def user_start_game
        input = gets.chomp
        input.capitalize
        input.capitalize
    end

    def start
        start_screen
        input = gets.chomp
        if input.capitalize == 'Go'
            create_players
            create_decks
            puts "Worx"
        else
            p "Invalid Input"
        end
    end
end