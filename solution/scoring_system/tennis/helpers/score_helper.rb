module ScoringSystem
  module Tennis
    module Helpers
      # Module to manage the scoring of the tennis tournament.
      module ScoreHelper
        private

        # Return the current game result based on the points scored by the players.
        def game_result
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
