class Turn
    attr_reader :player1, :player2, :spoils_of_war
     def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @spoils_of_war = []
     end

     def type
        return :mutually_assured_destruction if deck_is_less_than_3?
        if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
            :basic
        elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2) 
            :mutually_assured_destruction
        elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) 
            :war
        end
     end

     def deck_is_less_than_3?
        @player1.deck.cards.length < 3 || player2.deck.cards.length < 3
     end

     def find_winner_basic
        if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
            @player1
        elsif @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
            @player2
        end
     end

     def find_winner_war
        if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
            @player1
        elsif @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2)
            @player2
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
        when :mutually_assured_destruction
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
            3.times do
                @spoils_of_war << player1.deck.remove_card
                @spoils_of_war << player2.deck.remove_card
            end
        end
     end

     def award_spoils(winner)
        if winner == "No Winner"
            @spoils_of_war = []
        end
        @spoils_of_war.each do |card|
            winner.deck.add_card(card)
        end
     end
end