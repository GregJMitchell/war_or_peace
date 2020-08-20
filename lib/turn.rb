class Turn
    attr_reader :player1, :player2, :spoils_of_war
     def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @spoils_of_war = []
     end

     def type
        if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
            :basic
        elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) &&
              @player1.deck.rank_of_card_at(2) != @player2.deck.rank_of_card_at(2)
            :war
        else
            :mutually_assured_destruction
        end
     end

     def find_winner_basic
        if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
            @player1.deck
        elsif @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
            @player2.deck
        end
     end

     def find_winner_war
        if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
            @player1.deck
        elsif @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2)
            @player2.deck
        end
     end

     def find_winner_mad
        'No Winner'
     end

     def winner
        mad_result = find_winner_mad
        case type
        when :basic
            find_winner_basic
        when :war
            find_winner_war
        else
          mad_result
        end
     end

     def pile_cards
        if type == :basic
            @spoils_of_war << player1.deck.remove_card
            @spoils_of_war << player2.deck.remove_card
        elsif type == :war
            3.times do 
                @spoils_of_war << player1.deck.remove_card
                @spoils_of_war << player2.deck.remove_card
            end
        else

        end
     end
end