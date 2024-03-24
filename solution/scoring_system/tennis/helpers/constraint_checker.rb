module ScoringSystem
  module Tennis
    module Helpers
      # Module to manage constraint checks for the tennis tournament.
      module ConstraintChecker
        private

        # Check if the contestant is the player.
        def is_player?(contestant)
          contestant == player.name
        end

        # Check if no points have been scored by the contestants yet in the game.
        def no_scored_points?
          players.all?(&Constants::ZERO_POINT)
        end
      end
    end
  end
end
