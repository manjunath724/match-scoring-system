module ScoringSystem
  module Tennis
    module Helpers
      # Module to manage the scoring of the tennis tournament.
      module ScoreHelper
        private

        # Declare the contestant as the winner of the game.
        def declare_winner(contestant)
          contestant.game += 1
          contestant.winner = true
        end

        # Declare the contestant as the winner of the set and reset the games and points of the players.
        def update_set(contestant)
          contestant.set += 1
          reset_games
          reset_flags
        end

        # Reset the points of the players after a game is won.
        def reset_points
          players.each { |contestant| contestant.point = 0 }
        end

        # Reset the games of the players after a set is won.
        def reset_games
          players.each { |contestant| contestant.game = 0 }
        end

        # Reset the flags after a point is scored.
        def reset_flags
          @deuce = false
          players.each do |contestant|
            contestant.advantage = false
            contestant.winner = false
          end
        end

        # Determine if the game is in a state of Deuce or Advantage.
        # If the points scored by the players are equal, the game is in a state of Deuce.
        # If the points scored by the players differ by 1, the player with the higher points has the advantage.
        #
        # The reason <=> is not used here is because 3 <=> 1 will return 1, which is not the expected condition for advantage.
        def determine_deuce_vs_advantage
          case player.point - opponent.point
          when 1
            player.advantage = true
          when -1
            opponent.advantage = true
          when 0
            @deuce = true
          end
        end

        # Return the current game result based on the points scored by the players.
        def game_result
          # Display the Tie-Break state if the game is tied at 6-6 and no further points have been scored yet.
          return ", #{Constants::TIE_BREAK}" if tie_break? && no_scored_points?

          # Display the winner or advantage of the player if the player has scored the required points to win the game.
          players.each do |contestant|
            return ", #{Constants::WINNER} #{contestant.name}" if contestant.winner
            return ", #{Constants::ADVANTAGE} #{contestant.name}" if contestant.advantage
          end

          # Display the Deuce state if the points scored by the players are equal.
          return ", #{Constants::DEUCE}" if @deuce

          # Display the points scored by the players if the game is in progress.
          return '' if no_scored_points?
          ", #{Constants::SCORES[player.point]}-#{Constants::SCORES[opponent.point]}"
        end
      end
    end
  end
end
