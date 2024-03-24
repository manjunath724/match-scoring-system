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

        # Check if the contestant has at least scored 4 points and is leading the opponent by 2 points.
        def leading?(contestant, opponent = opponent_of(contestant))
          contestant.point >= 4 && contestant.point - opponent.point >= 2
        end

        # Get the opponent of the contestant.
        def opponent_of(contestant)
          player == contestant ? opponent : player
        end

        # Check if the contestant can be declared as the winner.
        # The contestant should have scored at least 6 games and should be leading by 2 games to be declared as the winner.
        # If the contestant has scored 7 games and the opponent has scored 6 games after a Tie-Break, the leading contestant is declared as the winner.
        def can_finalize_winner?(contestant, opponent = opponent_of(contestant))
          (contestant.game >= 6 && contestant.game - opponent.game >= 2) || (contestant.game == 7 && opponent.game == 6)
        end

        # Check if the contestants should have scored at least 3 points each.
        # This is to determine if the game is in a state of Deuce or Advantage.
        def eligible_for_winning?
          players.all?(&Constants::GTE_THREE)
        end

        # Check if no points have been scored by the contestants yet in the game.
        def no_scored_points?
          players.all?(&Constants::ZERO_POINT)
        end

        # Tie-Break is a special case where the game is tied at 6-6. The player who scores 7 points first wins the game.
        def tie_break?
          players.all?(&Constants::TIE_BREAK_GAME)
        end
      end
    end
  end
end
